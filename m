From: stu.hsieh@mediatek.com (Stu Hsieh)
Date: Thu, 28 Jun 2018 11:45:37 +0800
Subject: [PATCH v7 00/29] Add support for mediatek SOC MT2712
In-Reply-To: <20180625084740.GN2958@phenom.ffwll.local>
References: <1529482771-2153-1-git-send-email-stu.hsieh@mediatek.com>
 <20180625084740.GN2958@phenom.ffwll.local>
Message-ID: <1530157537.11190.53.camel@mtksdccf07>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Daniel Vetter:

On Mon, 2018-06-25 at 10:47 +0200, Daniel Vetter wrote:
> On Wed, Jun 20, 2018 at 04:19:02PM +0800, Stu Hsieh wrote:
> > This patch add support for the Mediatek MT2712 DISP subsystem.
> > MT2712 is base on MT8173, there are some difference as following:
> > MT2712 support three disp output(two ovl and one rdma)
> > 
> > Change in v6:
> > - Update commit message for the patch
> >   "drm/mediatek: Update the definition of connection from RDMA1 to DPI0"
> 
> Just a drive-by comment on the mediatek driver:
> 
> As far as I can see mtk_drm_gem.c reimplements the cma helpers as a
> copypaste job. Any reasons why you're not using the normal cma helpers?
> 
> Thanks, Daniel
> > 

In the beginning, we develop mtk_drm_gem.c by referring other platform.
We will try to use the normal cma helpers according to your idea.

Thanks,
Stu

> > Stu Hsieh (29):
> >   drm/mediatek: update dt-bindings for mt2712
> >   drm/mediatek: support maximum 64 mutex mod
> >   drm/mediatek: add ddp component AAL1
> >   drm/mediatek: add ddp component OD1
> >   drm/mediatek: add ddp component PWM1
> >   drm/mediatek: add ddp component PWM2
> >   drm/mediatek: add component DPI1
> >   drm/mediatek: add component DSI2
> >   drm/mediatek: add component DSI3
> >   drm/mediatek: add the DSI1 for component init condition
> >   drm/mediatek: add connection from OD1 to RDMA1
> >   drm/mediatek: Update the definition of connection from RDMA1 to DPI0
> >   drm/mediatek: add connection from RDMA0 to DPI0
> >   drm/mediatek: add connection from RDMA0 to DSI2
> >   drm/mediatek: add connection from RDMA0 to DSI3
> >   drm/mediatek: add connection from RDMA1 to DPI1
> >   drm/mediatek: add connection from RDMA1 to DSI1
> >   drm/mediatek: add connection from RDMA1 to DSI2
> >   drm/mediatek: add connection from RDMA1 to DSI3
> >   drm/mediatek: add connection from RDMA2 to DPI0
> >   drm/mediatek: add connection from RDMA2 to DPI1
> >   drm/mediatek: add connection from RDMA2 to DSI1
> >   drm/mediatek: add connection from RDMA2 to DSI2
> >   drm/mediatek: add connection from RDMA2 to DSI3
> >   drm/mediatek: add DPI1 support for mutex
> >   drm/mediatek: add DSI2 support for mutex
> >   drm/mediatek: add DSI3 support for mutex
> >   drm/mediatek: add third ddp path
> >   drm/mediatek: Add support for mediatek SOC MT2712
> > 
> >  .../bindings/display/mediatek/mediatek,disp.txt    |   2 +-
> >  drivers/gpu/drm/mediatek/mtk_drm_crtc.c            |   3 +
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp.c             | 235 ++++++++++++++++++---
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c        |  15 +-
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h        |  10 +-
> >  drivers/gpu/drm/mediatek/mtk_drm_drv.c             |  47 ++++-
> >  drivers/gpu/drm/mediatek/mtk_drm_drv.h             |   5 +-
> >  7 files changed, 274 insertions(+), 43 deletions(-)
> > 
> > -- 
> > 2.12.5
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel at lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
