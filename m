From: yt.shen@mediatek.com (YT Shen)
Date: Mon, 5 Dec 2016 21:01:23 +0800
Subject: [PATCH v10 13/13] drm/mediatek: add support for Mediatek SoC
 MT2701
In-Reply-To: <1be9b66b-eff2-4232-fe17-5d1735999d0b@gmail.com>
References: <1480070076-6196-1-git-send-email-yt.shen@mediatek.com>
 <1480070076-6196-14-git-send-email-yt.shen@mediatek.com>
 <1be9b66b-eff2-4232-fe17-5d1735999d0b@gmail.com>
Message-ID: <1480942883.18661.16.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-11-30 at 15:03 +0100, Matthias Brugger wrote:
> 
> On 25/11/16 11:34, YT Shen wrote:
> 
> >  static const struct of_device_id mtk_disp_rdma_driver_dt_match[] = {
> > +	{ .compatible = "mediatek,mt2701-disp-rdma",
> > +	  .data = &mt2701_rdma_driver_data},
> >  	{ .compatible = "mediatek,mt8173-disp-rdma",
> >  	  .data = &mt8173_rdma_driver_data},
> >  	{},
> 
> [...]
> 
> >  static const struct of_device_id ddp_driver_dt_match[] = {
> > +	{ .compatible = "mediatek,mt2701-disp-mutex", .data = mt2701_mutex_mod},
> >  	{ .compatible = "mediatek,mt8173-disp-mutex", .data = mt8173_mutex_mod},
> >  	{},
> >  };
> 
> [...]
> 
> >
> >  static const struct of_device_id mtk_disp_color_driver_dt_match[] = {
> > +	{ .compatible = "mediatek,mt2701-disp-color",
> > +	  .data = &mt2701_color_driver_data},
> >  	{ .compatible = "mediatek,mt8173-disp-color",
> >  	  .data = &mt8173_color_driver_data},
> >  	{},
> 
> [...]
> 
> >  static const struct of_device_id mtk_drm_of_ids[] = {
> > +	{ .compatible = "mediatek,mt2701-mmsys",
> > +	  .data = &mt2701_mmsys_driver_data},
> >  	{ .compatible = "mediatek,mt8173-mmsys",
> >  	  .data = &mt8173_mmsys_driver_data},
> >  	{ }
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > index 0569f2e..f63cc91 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > @@ -1203,6 +1203,7 @@ static int mtk_dsi_remove(struct platform_device *pdev)
> >  }
> >
> >  static const struct of_device_id mtk_dsi_of_match[] = {
> > +	{ .compatible = "mediatek,mt2701-dsi" },
> >  	{ .compatible = "mediatek,mt8173-dsi" },
> >  	{ },
> >  };
> 
> [...]
> 
> >
> >  static const struct of_device_id mtk_mipi_tx_match[] = {
> > +	{ .compatible = "mediatek,mt2701-mipi-tx",
> > +	  .data = &mt2701_mipitx_data },
> >  	{ .compatible = "mediatek,mt8173-mipi-tx",
> >  	  .data = &mt8173_mipitx_data },
> >  	{},
> 
> I'm not sure if I missed some, but you should update the binding 
> description for newly added bindings.
> 
> Thanks a lot,
> Matthias
Oh, you are right.  I thought there is already sent binding description
but actually no.  I will update this part for newly added bindings.

Thanks for informing.
yt.shen
