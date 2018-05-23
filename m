From: stu.hsieh@mediatek.com (Stu Hsieh)
Date: Wed, 23 May 2018 17:31:09 +0800
Subject: [PATCH v2 4/4] drm/mediatek: add connection from OD1 to RDMA1
In-Reply-To: <1527055278.21354.3.camel@mtksdaap41>
References: <20180523022517.12103-1-stu.hsieh@mediatek.com>
 <20180523022517.12103-5-stu.hsieh@mediatek.com>
 <1527055278.21354.3.camel@mtksdaap41>
Message-ID: <1527067869.19074.29.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, CK:

On Wed, 2018-05-23 at 14:01 +0800, CK Hu wrote:
> Hi, Stu:
> 
> On Wed, 2018-05-23 at 10:25 +0800, Stu Hsieh wrote:
> > This patch add the connection from OD1 to RDMA1 for ext path.
> > 
> 
> I would like to apply this patch before the patch 'Add support for
> mediatek SOC MT2712' because this patch is necessary for mt2712.
ok

> 
> Regards,
> CK
> 
> > Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > index 3c7bd453cf42..0450ecbbc356 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > @@ -193,6 +193,9 @@ static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
> >  	} else if (cur == DDP_COMPONENT_GAMMA && next == DDP_COMPONENT_RDMA1) {
> >  		*addr = DISP_REG_CONFIG_DISP_GAMMA_MOUT_EN;
> >  		value = GAMMA_MOUT_EN_RDMA1;
> > +	} else if (cur == DDP_COMPONENT_OD1 && next == DDP_COMPONENT_RDMA1) {
> > +		*addr = DISP_REG_CONFIG_DISP_OD_MOUT_EN;
> > +		value = OD1_MOUT_EN_RDMA1;
> >  	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI0) {
> >  		*addr = DISP_REG_CONFIG_DISP_RDMA1_MOUT_EN;
> >  		value = RDMA1_MOUT_DPI0;
> 
> 
