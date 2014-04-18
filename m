From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 18 Apr 2014 17:02:41 +0530
Subject: [PATCH v2] phy: core: make NULL a valid phy reference if
 !CONFIG_GENERIC_PHY
In-Reply-To: <20140416151947.GF28035@saruman.home>
References: <1397648901-4450-1-git-send-email-grygorii.strashko@ti.com>
 <20140416151947.GF28035@saruman.home>
Message-ID: <53510D59.3000509@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wednesday 16 April 2014 08:49 PM, Felipe Balbi wrote:
> On Wed, Apr 16, 2014 at 02:48:21PM +0300, Grygorii Strashko wrote:
>> This fixes a regression on Keystone 2 platforms caused by patch
>> 57303488cd37da58263e842de134dc65f7c626d5
>> "usb: dwc3: adapt dwc3 core to use Generic PHY Framework" which adds
>> optional support of generic phy in DWC3 core.
>>
>> On Keystone 2 platforms the USB is not working now because
>> CONFIG_GENERIC_PHY isn't set and, as result, Generic PHY APIs stubs
>> return -ENOSYS always. The log shows:
>>  dwc3 2690000.dwc3: failed to initialize core
>>  dwc3: probe of 2690000.dwc3 failed with error -38
>>
>> Hence, fix it by making NULL a valid phy reference in Generic PHY
>> APIs stubs in the same way as it was done by the patch
>> 04c2facad8fee66c981a51852806d8923336f362 "drivers: phy: Make NULL
>> a valid phy reference".
>>
>> CC: Kishon Vijay Abraham I <kishon@ti.com>
>> CC: Felipe Balbi <balbi@ti.com>
>> CC: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> I thought I'd already acked this one... oh well, need more coffee:

Indeed.. you acked the v1 of this patch series and already queued the v2 with
your acked by ;-)

Cheers
Kishon

> 
> Acked-by: Felipe Balbi <balbi@ti.com>
> 
