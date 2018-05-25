From: stu.hsieh@mediatek.com (Stu Hsieh)
Date: Fri, 25 May 2018 17:36:53 +0800
Subject: [PATCH v3 3/8] drm/mediatek: add connection from OD1 to RDMA1
In-Reply-To: <1527218776.27165.5.camel@mtksdaap41>
References: <1527215665-11937-1-git-send-email-stu.hsieh@mediatek.com>
 <1527215665-11937-4-git-send-email-stu.hsieh@mediatek.com>
 <1527218776.27165.5.camel@mtksdaap41>
Message-ID: <1527241013.11190.11.camel@mtksdccf07>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, CK:

For this patch, I would move it after "add ddp component OD1"
And add this line "#define OD1_MOUT_EN_RDMA1              BIT(16)" from
the path "Add support for mediatek SOC MT2712" to this patch

Regards,
Stu

On Fri, 2018-05-25 at 11:26 +0800, CK Hu wrote:
> Hi, Stu:
> 
> On Fri, 2018-05-25 at 10:34 +0800, stu.hsieh at mediatek.com wrote:
> > From: Stu Hsieh <stu.hsieh@mediatek.com>
> > 
> > This patch add the connection from OD1 to RDMA1 for ext path.
> > 
> 
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> 
> > Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > index 47ffa240bd25..0f568dd853d8 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > @@ -151,6 +151,9 @@ static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
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
