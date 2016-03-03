From: dianders@chromium.org (Doug Anderson)
Date: Thu, 3 Mar 2016 09:44:48 -0800
Subject: [PATCH] arm64/dma-mapping: Add DMA_ATTR_ALLOC_SINGLE_PAGES support
In-Reply-To: <1456944866-15990-1-git-send-email-yong.wu@mediatek.com>
References: <1456944866-15990-1-git-send-email-yong.wu@mediatek.com>
Message-ID: <CAD=FV=VOJT_Nd67O21J2-rabXRQ2=iTJxP8yCAty2xFhcVupGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Mar 2, 2016 at 10:54 AM, Yong Wu <yong.wu@mediatek.com> wrote:
> Sometimes it is not worth for the iommu allocating big chunks.
> Here we enable DMA_ATTR_ALLOC_SINGLE_PAGES which could help avoid to
> allocate big chunks while iommu allocating buffer.
>
> More information about this attribute, please check Doug's commit[1].
>
> [1]: https://lkml.org/lkml/2016/1/11/720
>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Suggested-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>
> Our video drivers may soon use this.
>
>  arch/arm64/mm/dma-mapping.c |  4 ++--
>  drivers/iommu/dma-iommu.c   | 14 ++++++++++----
>  include/linux/dma-iommu.h   |  4 ++--
>  3 files changed, 14 insertions(+), 8 deletions(-)

It should also be mentioned that this depends on commit df05c6f6e0bb
("ARM: 8506/1: common: DMA-mapping: add DMA_ATTR_ALLOC_SINGLE_PAGES
attribute") which is not in mainline quite yet.

Also please CC Marek Szyprowski on any future patches in this area
since I saw a patch series from him that was touching this same area.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
