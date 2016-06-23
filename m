From: sstabellini@kernel.org (Stefano Stabellini)
Date: Thu, 23 Jun 2016 17:00:20 +0100 (BST)
Subject: [PATCH] arm:swiotlb:keep disabled in default configuration
In-Reply-To: <CAHA9rcjcAbkoHyonqKzNv7a1v=08Fy1weEnsyG1C+6hdib9bwQ@mail.gmail.com>
References: <1466684826-26682-1-git-send-email-manjeet.p@samsung.com>
 <CAPbh3ruZa4jA14emroSJAxdxP+56A4kW3ZDOxO7AJrzpMgDBwA@mail.gmail.com>
 <CAHA9rcjcAbkoHyonqKzNv7a1v=08Fy1weEnsyG1C+6hdib9bwQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1606231657390.2575@sstabellini-ThinkPad-X260>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 23 Jun 2016, Stefano Stabellini wrote:
> On Jun 23, 2016 8:27 AM, "Manjeet Pawar" <manjeet.p@samsung.com> wrote:
> >
> > From: Rohit Thapliyal <r.thapliyal@samsung.com>
> >
> > swiotlb implementation not required to be enabled in arm and
> > disabling it reduces uImage size by 16KB.
> >
> 
> How so? There are no DMA operations on ARM?

Xen actively uses the swiotlb on ARM, see

arch/arm64/include/asm/dma-mapping.h:get_dma_ops
arch/arm/xen/mm.c:xen_swiotlb_dma_ops


> > Signed-off-by: Rohit Thapliyal <r.thapliyal@samsung.com>
> > Signed-off-by: Ajeet Kumar Yadav <ajeet.y@samsung.com>
> > ---
> >  arch/arm/Kconfig |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 90542db..ae65f29 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -1754,7 +1754,7 @@ config SECCOMP
> >           defined by each seccomp mode.
> >
> >  config SWIOTLB
> > -       def_bool y
> > +       def_bool n
> >
> >  config IOMMU_HELPER
> >         def_bool SWIOTLB
> > --
> > 1.7.9.5
> >
> 
