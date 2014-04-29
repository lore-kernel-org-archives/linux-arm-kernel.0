From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Apr 2014 15:30:16 +0200
Subject: [alsa-devel] [PATCH] ASoC: fsl: select SND_SOC_IMX_PCM_DMA where
 needed
In-Reply-To: <535F8594.40609@metafoo.de>
References: <6606961.lAGLvkNsEj@wuerfel> <4270904.84oGcCXL4B@wuerfel>
 <535F8594.40609@metafoo.de>
Message-ID: <4275868.O962kiiyJa@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 April 2014 12:57:24 Lars-Peter Clausen wrote:
> On 04/29/2014 12:37 PM, Arnd Bergmann wrote:
> > On Tuesday 29 April 2014 07:07:33 Alexander Shiyan wrote:
> >> Mon, 28 Apr 2014 23:12:14 +0200 ?? Arnd Bergmann <arnd@arndb.de>:
> >>> On Tuesday 29 April 2014 00:35:41 Alexander Shiyan wrote:
> >>>>
> >>>> So, I don't understand why this error happen, as well as I can not
> >>>> reproduce this...
> >>>
> >>> It's probably CONFIG_SND_SOC_IMX_PCM_DMA=m and CONFIG_SND_SOC_FSL_SSI=y then.
> >>> What is the intended behavior in this case? Should CONFIG_SND_SOC_FSL_SSI
> >>> be forced to be a module as well?
> >>
> >> Hmm, yes...
> >> I thought that I had already solved a similar problem for the earlier
> >> version of the patch ...
> >
> > How about this?
> 
> Having FSL_SSI/FSL_SPDIF, but not SND_SOC_IMX_PCM_DMA does not make sense on 
> iMX.
> So how about:
> 
>         select SND_SOC_IMX_PCM_DMA if SND_IMX_SOC
> 
> and remove all the other 'select SND_SOC_IMX_PCM_DMA' statements. That's in 
> my opinion much nicer.

Yes, makes sense. Should I do another version of the patch?

	Arnd
