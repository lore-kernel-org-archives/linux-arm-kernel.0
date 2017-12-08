From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Fri, 8 Dec 2017 10:11:42 +0100
Subject: [PATCH V6 4/7] OF: properties: Implement get_match_data() callback
In-Reply-To: <661cbe4d-ea33-3e84-b5f2-ab6517cbb135@codeaurora.org>
References: <1512493493-6464-1-git-send-email-okaya@codeaurora.org>
 <1512493493-6464-5-git-send-email-okaya@codeaurora.org>
 <20171207141029.575c0a03@karo-electronics.de>
 <def8e351-bc2d-7adc-fdc5-362b365302a8@codeaurora.org>
 <20171207162036.6a71a4f5@karo-electronics.de>
 <661cbe4d-ea33-3e84-b5f2-ab6517cbb135@codeaurora.org>
Message-ID: <20171208101142.1ea9bc13@karo-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, 7 Dec 2017 12:50:50 -0500 Sinan Kaya wrote:
> On 12/7/2017 10:20 AM, Lothar Wa?mann wrote:
> > Hi,
> > 
> > On Thu, 7 Dec 2017 09:45:31 -0500 Sinan Kaya wrote:
> >> On 12/7/2017 8:10 AM, Lothar Wa?mann wrote:
> >>>> +void *of_fwnode_get_match_data(const struct fwnode_handle *fwnode,
> >>>> +			       struct device *dev)
> >>> Shouldn't this be 'const void *of_fwnode_get_match_data
> >>
> >> OF keeps the driver data as a (const void*) internally. ACPI keeps the
> >> driver data as kernel_ulong_t in struct acpi_device_id.
> >>
> >> I tried to find the middle ground here by converting output to void*
> >> but not keeping const.
> >>
> > It should be no problem to cast a (const void *) to an unsigned long
> > data type (without const qualifier).
> > 
> 
> It is the other way around. If I change this API to return a a (const void*),
> the device_get_match_data() function need to return a (const void *).
> 
> While implementing the ACPI piece, I have to convert an unsigned long to
> (const void *) in ACPI code so that the APIs are compatible.
> 
Just one more remark: Do you need write access to the data the pointer
returned by device_get_match_data() or of_fwnode_get_match_data()
points to?
If not, the return type of those functions should be 'const void *'.


Lothar Wa?mann
