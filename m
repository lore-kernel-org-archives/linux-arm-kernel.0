From: yt.shen@mediatek.com (YT Shen)
Date: Mon, 12 Sep 2016 18:16:42 +0800
Subject: [PATCH v7 4/9] drm/mediatek: update display module connections
In-Reply-To: <1473147546.11736.7.camel@mtksdaap41>
References: <1472815484-43821-1-git-send-email-yt.shen@mediatek.com>
 <1472815484-43821-5-git-send-email-yt.shen@mediatek.com>
 <1473147546.11736.7.camel@mtksdaap41>
Message-ID: <1473675402.12398.28.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi CK,

On Tue, 2016-09-06 at 15:39 +0800, CK Hu wrote:
> Hi, YT:
> 
> On Fri, 2016-09-02 at 19:24 +0800, YT Shen wrote:
> > update connections for OVL, RDMA, BLS, DSI
> > 
> > Signed-off-by: YT Shen <yt.shen@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> > 
> 
> [snip...]
> 
> > @@ -111,6 +119,9 @@ static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
> >  	if (cur == DDP_COMPONENT_OVL0 && next == DDP_COMPONENT_COLOR0) {
> >  		*addr = DISP_REG_CONFIG_DISP_OVL0_MOUT_EN;
> >  		value = OVL0_MOUT_EN_COLOR0;
> > +	} else if (cur == DDP_COMPONENT_OVL0 && next == DDP_COMPONENT_RDMA0) {
> > +		*addr = DISP_REG_CONFIG_DISP_OVL_MOUT_EN;
> > +		value = OVL_MOUT_EN_RDMA;
> >  	} else if (cur == DDP_COMPONENT_OD && next == DDP_COMPONENT_RDMA0) {
> >  		*addr = DISP_REG_CONFIG_DISP_OD_MOUT_EN;
> >  		value = OD_MOUT_EN_RDMA0;
> > @@ -148,6 +159,9 @@ static unsigned int mtk_ddp_sel_in(enum mtk_ddp_comp_id cur,
> >  	} else if (cur == DDP_COMPONENT_OVL1 && next == DDP_COMPONENT_COLOR1) {
> >  		*addr = DISP_REG_CONFIG_DISP_COLOR1_SEL_IN;
> >  		value = COLOR1_SEL_IN_OVL1;
> > +	} else if (cur == DDP_COMPONENT_BLS && next == DDP_COMPONENT_DSI0) {
> 
> DDP_COMPONENT_BLS is a new symbol which is defined in 9th patch of this
> series. I think the definition of DDP_COMPONENT_BLS should be in front
> of this patch.
OK, we will move the definition to this patch.

Regards,
yt.shen

> 
> > +		*addr = DISP_REG_CONFIG_DSI_SEL;
> > +		value = DSI_SEL_IN_BLS;
> >  	} else {
> >  		value = 0;
> >  	}
> > @@ -155,6 +169,15 @@ static unsigned int mtk_ddp_sel_in(enum mtk_ddp_comp_id cur,
> >  	return value;
> >  }
> >  
> 
> Regards,
> CK
> 
> 
