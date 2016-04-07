From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 7 Apr 2016 13:45:19 -0400
Subject: [PATCH 2/2] pci, acpi: free IO resource during shutdown
In-Reply-To: <20160407160624.GB8780@localhost>
References: <1457389310-3538-1-git-send-email-okaya@codeaurora.org>
 <1457389310-3538-2-git-send-email-okaya@codeaurora.org>
 <20160407160624.GB8780@localhost>
Message-ID: <57069CAF.8090803@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/7/2016 12:06 PM, Bjorn Helgaas wrote:
>> __release_pci_root_info function if the region type is IO.
> I don't know what "removing a slot" means.  You're changing
> pci_root.c, so I assume this is really an ACPI host bridge removal?
> 

Correct, I'm removing the host bridge.

> The release should correspond to a mapping, and the changelog should
> point out where that mapping happens so we can see the symmetry.
> 

I apologize. This is based on Tomasz's v5 patch here.

https://github.com/semihalf-nowicki-tomasz/linux/blob/pci-acpi-v5/drivers/acpi/pci_root.c


> You say this is undoing the effect of pci_remap_iospace(), but that's
> only called by native drivers and the generic (OF) driver, not by
> pci_root.c.

See the ACPI root bridge driver above.

> 
> Please combine this with the previous patch so we have the new
> function and its use in the same patch.
> 

I can do that. I was trying to keep the reviews as small as possible.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
