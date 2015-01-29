From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 29 Jan 2015 15:23:33 +0100
Subject: [PATCH] ASoC: Samsung: add missing I2C/SPI dependencies
In-Reply-To: <20150129114134.GC21293@sirena.org.uk>
References: <1815674.ObkQWLfgIW@wuerfel> <20150129114134.GC21293@sirena.org.uk>
Message-ID: <3641576.5ROmxlmVfH@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 29 January 2015 11:41:34 Mark Brown wrote:
> On Wed, Jan 28, 2015 at 10:28:55PM +0100, Arnd Bergmann wrote:
> > The SND_SOC_ARNDALE_RT5631_ALC5631 selects the rt5631 codec
> > that requires I2C to work, so we get a build error if I2C
> > is disabled:
> 
> You rather buried the lead about there being other drivers in this
> changelog, makes the code a bit surprising when you find it.
> 
> >  config SND_SOC_SPEYSIDE
> >  	tristate "Audio support for Wolfson Speyside"
> > -	depends on SND_SOC_SAMSUNG && MACH_WLF_CRAGG_6410
> > +	depends on SND_SOC_SAMSUNG && MACH_WLF_CRAGG_6410 && SPI_MASTER
> >  	select SND_SAMSUNG_I2S
> >  	select SND_SOC_WM8996
> >  	select SND_SOC_WM9081
> 
> Why only add a dependency on SPI here?

I don't know, definitely my mistake. I had squashed three older patches
together here, which resulted in the slightly strange changelog (I
picked the one that explained it best and then tried to modify it
to cover all changes) as well as the missing I2C dependency.

I'll re-check all other drivers in this directory too and then send
a new patch.

	Arnd
