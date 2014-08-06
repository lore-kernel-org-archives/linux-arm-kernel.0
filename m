From: ohaugan@codeaurora.org (Olav Haugan)
Date: Wed, 06 Aug 2014 16:28:45 -0700
Subject: [PATCH v4 1/1] iommu-api: Add map_sg/unmap_sg functions
In-Reply-To: <20140806201740.GW9809@8bytes.org>
References: <1406854484-3848-1-git-send-email-ohaugan@codeaurora.org>
 <1406854484-3848-2-git-send-email-ohaugan@codeaurora.org>
 <20140805151323.GB19709@laptop.dumpdata.com>
 <53E26127.1040805@codeaurora.org> <20140806201740.GW9809@8bytes.org>
Message-ID: <53E2BA2D.1050007@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/6/2014 1:17 PM, Joerg Roedel wrote:
> On Wed, Aug 06, 2014 at 10:08:55AM -0700, Olav Haugan wrote:
>> so you are suggesting that I check in "bus_set_iommu()" whether the
>> driver has set the map_sg/unmap_sg function pointers or not and if not
>> set it to the default? Is bus_set_iommu() the only way drivers can set
>> up the callbacks?
> 
> This doesn't work as the iommu_ops are now const. You have to either
> update the iommu drivers individually to point to the default function,
> or you do the check in the API function itself and fall back to the
> default it no call-back is provided.
> 

Ok, then I think it is better to just leave the fallback where it is now
in the function itself.

Thanks,

Olav

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
