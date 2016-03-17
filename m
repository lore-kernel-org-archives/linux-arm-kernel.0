From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 17 Mar 2016 17:14:34 +0100
Subject: [PATCH] arm64: dma-mapping: fix dma_to_phys API for IOMMU
 attached devices
In-Reply-To: <56EAD63E.2010103@codeaurora.org>
References: <1458229833-4886-1-git-send-email-okaya@codeaurora.org>
 <56EAD3E2.5070109@arm.com> <56EAD63E.2010103@codeaurora.org>
Message-ID: <3165610.Gdh8F6ejPI@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 March 2016 12:07:26 Sinan Kaya wrote:
> On 3/17/2016 11:57 AM, Robin Murphy wrote:
>
> Let me know which direction I should go. 
> 
> 1. Fix phys_to_dma and keep dma_to_phys as in the patch.
> 2. Remove both of the API from header file, move it to where it is needed. Rename them as swio_phys_to_dma etc.

Use 2.

It has been a long way to remove all virt_to_bus/bus_to_virt users
from the common architectures, we are not putting them back under
a different name.

Drivers already know the physical address because that is what they
put into dma_map_*() in the first place.

	Arnd
