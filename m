From: joro@8bytes.org (Joerg Roedel)
Date: Wed, 6 Aug 2014 22:17:40 +0200
Subject: [PATCH v4 1/1] iommu-api: Add map_sg/unmap_sg functions
In-Reply-To: <53E26127.1040805@codeaurora.org>
References: <1406854484-3848-1-git-send-email-ohaugan@codeaurora.org>
 <1406854484-3848-2-git-send-email-ohaugan@codeaurora.org>
 <20140805151323.GB19709@laptop.dumpdata.com>
 <53E26127.1040805@codeaurora.org>
Message-ID: <20140806201740.GW9809@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 06, 2014 at 10:08:55AM -0700, Olav Haugan wrote:
> so you are suggesting that I check in "bus_set_iommu()" whether the
> driver has set the map_sg/unmap_sg function pointers or not and if not
> set it to the default? Is bus_set_iommu() the only way drivers can set
> up the callbacks?

This doesn't work as the iommu_ops are now const. You have to either
update the iommu drivers individually to point to the default function,
or you do the check in the API function itself and fall back to the
default it no call-back is provided.


	Joerg
