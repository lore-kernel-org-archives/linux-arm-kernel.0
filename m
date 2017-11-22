From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 22 Nov 2017 11:24:35 -0500
Subject: [PATCH 12/30] Drivers: ide: deprecate pci_get_bus_and_slot()
In-Reply-To: <20171122075302.GB26583@kroah.com>
References: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
 <1511328675-21981-13-git-send-email-okaya@codeaurora.org>
 <20171122075302.GB26583@kroah.com>
Message-ID: <ae1b877c-1398-9099-4b00-d3d0c6ff9cb1@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/22/2017 2:53 AM, Greg KH wrote:
> On Wed, Nov 22, 2017 at 12:30:57AM -0500, Sinan Kaya wrote:
>> pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
>> where a PCI device is present. This restricts the device drivers to be
>> reused for other domain numbers.
>>
>> Use pci_get_domain_bus_and_slot() with a domain number of 0 where we can't
>> extract the domain number. Other places, use the actual domain number from
>> the device.
> 
> While this is a great generic text, you might want to make it a bit more
> custom to each specific patch.  For example, you don't use a domain of 0
> in this one, so the text is a bit wrong and confusing if you look at it
> stand-alone.
> 
> I like the series and the idea, just fix up this text in some of the
> patches and you should be fine.

OK. Will do on the next version.


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
