From: garlic.tseng@mediatek.com (Garlic Tseng)
Date: Thu, 16 Jun 2016 09:40:11 +0800
Subject: [alsa-devel] [PATCH v4 3/9] ASoC: mediatek: let mt8173 use
 mediatek common structure
In-Reply-To: <1465988242.30493.6.camel@mtksdaap41>
References: <1465802806-19197-1-git-send-email-garlic.tseng@mediatek.com>
 <1465802806-19197-4-git-send-email-garlic.tseng@mediatek.com>
 <1465988242.30493.6.camel@mtksdaap41>
Message-ID: <1466041211.27083.3.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yingjoe, thanks for comments.

> > +config SND_SOC_MEDIATEK
> > +	tristate "SND_SOC_MEDIATEK"
> > +	depends on ARCH_MEDIATEK
> > +	help
> > +	  This adds ASoC driver for Mediatek boards
> > +	  that can be used with other codecs.
> > +	  Select Y if you have such device.
> > +	  If unsure select "N".
> > +
> >  config SND_SOC_MT8173
> >  	tristate "ASoC support for Mediatek MT8173 chip"
> >  	depends on ARCH_MEDIATEK
> > +	select SND_SOC_MEDIATEK
> >  	help
> >  	  This adds ASoC platform driver support for Mediatek MT8173 chip
> >  	  that can be used with other codecs.
> 
> It seems both SND_SOC_MT8173 and SND_SOC_MT2701 select SND_SOC_MEDIATEK,
> and enabling only SND_SOC_MEDIATEK itself is not really useful. Do we
> need to make SND_SOC_MEDIATEK user configurable option?

I'll make the config not user configurable, something like:

+config SND_SOC_MEDIATEK
+	tristate

> 
> If it is, we should at least have a proper config prompt instead of just
> "SND_SOC_MEDIATEK".
> 
> 
> > @@ -49,3 +59,4 @@ config SND_SOC_MT8173_RT5650_RT5676
> >  	  with the RT5650 and RT5676 codecs.
> >  	  Select Y if you have such device.
> >  	  If unsure select "N".
> > +
> 
> nit: This change is not necessary.

I'll fix it, thanks.

> 
> Joe.C
> 
> 
