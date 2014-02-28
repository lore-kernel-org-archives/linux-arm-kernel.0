From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Feb 2014 10:30:48 +0100
Subject: [PATCH v2 1/7] ARM: mm: Introduce archdata.dma_pfn_offset
In-Reply-To: <1393535872-20915-2-git-send-email-santosh.shilimkar@ti.com>
References: <1393535872-20915-1-git-send-email-santosh.shilimkar@ti.com>
 <1393535872-20915-2-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <6612551.WqU0SU4pc9@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 February 2014 16:17:46 Santosh Shilimkar wrote:
> From: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> In most of cases DMA addresses can be performed using offset value of
>  Bus address space relatively to physical address space as following:
> 
> PFN->DMA:
>  __pfn_to_phys(pfn + [-]dma_pfn_offset)
> 
> DMA->PFN:
>  __phys_to_pfn(dma_addr) + [-]dma_pfn_offset
> 
> This patch introduces new field dma_pfn_offset in ARM dev_archdata
> structure which has to be filed per-device at arch init time
> (simplest way is to use Platform bus notifier to handle
> BUS_NOTIFY_ADD_DEVICE event) and updates DMA address translation
> routines in order to accommodate bus offset value by default.
> 
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Olof Johansson <olof@lixom.net>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

This was my suggestion, and the implementation is trivial, so

Acked-by: Arnd Bergmann <arnd@arndb.de>

This should be most of what LinusW needs to generalize the
mach-integrator PCI DMA mapping.
