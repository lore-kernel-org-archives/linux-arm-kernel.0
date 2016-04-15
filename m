From: garlic.tseng@mediatek.com (YiMing (Garlic) Tseng)
Date: Fri, 15 Apr 2016 09:45:53 +0800
Subject: [alsa-devel] [RFC PATCH v2 5/5] ASoC: mediatek: Add
 mt2701-cs42448 driver and config option.
In-Reply-To: <1460637574.13240.19.camel@mtksdaap41>
References: <1460636070-37426-1-git-send-email-garlic.tseng@mediatek.com>
 <1460636070-37426-6-git-send-email-garlic.tseng@mediatek.com>
 <1460637574.13240.19.camel@mtksdaap41>
Message-ID: <1460684753.28853.9.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-04-14 at 20:39 +0800, Yingjoe Chen wrote:
> On Thu, 2016-04-14 at 20:14 +0800, Garlic Tseng wrote:
> > Add machine driver and config option for MT2701.
> > 
> > Signed-off-by: Garlic Tseng <garlic.tseng@mediatek.com>
> > ---
> >  sound/soc/mediatek/Kconfig                 |  21 ++
> >  sound/soc/mediatek/Makefile                |   3 +
> >  sound/soc/mediatek/mt2701/Makefile         |  20 ++
> >  sound/soc/mediatek/mt2701/mt2701-cs42448.c | 376 +++++++++++++++++++++++++++++
> >  4 files changed, 420 insertions(+)
> >  create mode 100644 sound/soc/mediatek/mt2701/Makefile
> >  create mode 100644 sound/soc/mediatek/mt2701/mt2701-cs42448.c
> > 
> > diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
> > index f7e789e..b190322 100644
> > --- a/sound/soc/mediatek/Kconfig
> > +++ b/sound/soc/mediatek/Kconfig
> > @@ -48,3 +48,24 @@ config SND_SOC_MT8173_RT5650_RT5676
> >  	  with the RT5650 and RT5676 codecs.
> >  	  Select Y if you have such device.
> >  	  If unsure select "N".
> > +
> > +config SND_SOC_MT2701
> 
> It seems we need different driver for different soc. So after this
> patch, SND_SOC_MEDIATEK only select driver for mt8173. Maybe it should
> be renamed to SND_SOC_MT8173 to reflect this.

Yes I think you are right. I'll do it.

> 
> > +	bool "SND_SOC_MT2701"
> 
> 
> Please check other config in this file and have a proper config prompt
> here.
> 
> Can we support module like mt8173?

We already support mt8173. I didn't change the config for mt8173 and it
works well before.


Next version I'll change SND_SOC_MEDIATEK to SND_SOC_MT8173 and check
the config prompt. 

> 
> > +	depends on SND_SOC_MEDIATEK
> > +	select SND_SOC_CS42XX8_I2C
> > +	help
> > +	  This adds ASoC driver for Mediatek MT2701 boards
> > +	  with the CS42448 codecs.
> > +	  Select Y if you have such device.
> > +	  If unsure select "N".
> 
> 
> Based on the Makefile, this is platform driver for mt2701. This should
> not depends on codec. Please update the help message and select.

Yes you are right. I'll do it.

> > +
> > +config SND_SOC_MT2701_CS42448
> > +	bool "SND_SOC_MT2701_CS42448"
> > +	depends on SND_SOC_MT2701
> > +	select SND_SOC_CS42XX8_I2C
> > +	help
> > +	  This adds ASoC driver for Mediatek MT2701 boards
> > +	  with the CS42448 codecs.
> > +	  Select Y if you have such device.
> > +	  If unsure select "N".
> > +
> > diff --git a/sound/soc/mediatek/Makefile b/sound/soc/mediatek/Makefile
> > index 5048165..60387ca 100644
> > --- a/sound/soc/mediatek/Makefile
> > +++ b/sound/soc/mediatek/Makefile
> > @@ -3,3 +3,6 @@ obj-$(CONFIG_SND_SOC_MT8173_MAX98090) += mt8173/
> >  obj-$(CONFIG_SND_SOC_MT8173_RT5650_RT5676) += mt8173/
> >  obj-$(CONFIG_SND_SOC_MT8173_RT5650_RT5514) += mt8173/
> >  obj-$(CONFIG_SND_SOC_MT8173_RT5650) += mt8173/
> > +
> > +# 2701 Machine support
> > +obj-$(CONFIG_SND_SOC_MT2701_CS42448) += mt2701/
> 
> Sorting, please put mt2701 before mt8173.

OK I'll do it next patch.


> Joe.C
> 
> 
