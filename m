From: ck.hu@mediatek.com (CK Hu)
Date: Thu, 21 Jul 2016 11:58:12 +0800
Subject: [PATCH v3 2/2] drm/mediatek: set mt8173 dithering function
In-Reply-To: <1469071288.26205.9.camel@mtksdaap41>
References: <1467877029-45236-1-git-send-email-bibby.hsieh@mediatek.com>
 <1467877029-45236-3-git-send-email-bibby.hsieh@mediatek.com>
 <1468809237.30644.28.camel@mtksdaap41>
 <1469071288.26205.9.camel@mtksdaap41>
Message-ID: <1469073492.11841.63.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Bibby:

On Thu, 2016-07-21 at 11:21 +0800, Bibby Hsieh wrote:
> Hi, CK
> 
> I'm appreciate your comments.
> 
> 

[snip...]

> > >  
> > > @@ -469,7 +484,7 @@ void mtk_crtc_ddp_irq(struct drm_crtc *crtc, struct mtk_ddp_comp *ovl)
> > >  	if (state->pending_config) {
> > >  		mtk_ddp_comp_config(ovl, state->pending_width,
> > >  				    state->pending_height,
> > > -				    state->pending_vrefresh);
> > > +				    state->pending_vrefresh, 0);
> > 
> > Why set bpc as 0 here? Maybe you have a assumption that OVL don't care
> > the bpc parameter. If one day OVL care it and we do not review here, the
> > bugs happen.
> > 
> Pass 0 means don't care, I will modify mtk_od_config() and
> mtk_gamma_config() to filter this condition.

Using 0 as 'don't care' looks tricky. Please add comments to describe
this.

> > >  
> > >  		state->pending_config = false;
> > >  	}

Regards,
CK
