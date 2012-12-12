From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Wed, 12 Dec 2012 13:06:14 +0530
Subject: [PATCH 4/4] DMA: PL330: add device tree property for DMA_MEMCPY
 capability
In-Reply-To: <201211301156.08060.b.zolnierkie@samsung.com>
References: <1351504796-24788-1-git-send-email-b.zolnierkie@samsung.com>
 <201210301021.42803.b.zolnierkie@samsung.com>
 <CAJe_ZhdOt+T65FdkE0SpQ37uGsS8SkFyJ9hHM3B_8S8f7GQAcQ@mail.gmail.com>
 <201211301156.08060.b.zolnierkie@samsung.com>
Message-ID: <CABb+yY0FxsZyBy=scTF31+QMWgHzKf7bNz8vsPowtiMkve7igg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 30, 2012 at 4:26 PM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:

> Thank you for explaining it.  Here is a patch implementing the idea:
>
> From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Subject: [PATCH] DMA: PL330: add peripherals map to the device tree
>
> Add device tree (DT) property ("peri-map") for storing indices
> of peripherals connected to DMAC and fix DT nodes of client
> drivers to use 'dma peripheral id' instead of 'dma request id'.
> Also instead of setting DMA_MEMCPY capability unconditionally in
> pl330_probe() do it only when "peri-map" DT property is present
> (idea from Jassi Brar).  It fixes the issue on ARM EXYNOS
> platforms using DT where pdma controller erroneously was used
> for DMA_MEMCPY operations instead of mdma one (it seems to work
> correctly but at the cost of worse performance).
>
Sorry, we need to change it as per new generic dma DT bindings
  http://git.infradead.org/users/vkoul/slave-dma.git/blob/refs/heads/next:/Documentation/devicetree/bindings/dma/dma.txt

Thanks.
