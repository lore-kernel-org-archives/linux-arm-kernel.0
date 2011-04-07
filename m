From: sbkim73@samsung.com (Sangbeom Kim)
Date: Thu, 07 Apr 2011 11:05:22 +0900
Subject: [alsa-devel] [PATCH 3/3] SoC: SAMSUNG: Add WM8580 PCM	Machine
	driver
In-Reply-To: <20110407011704.GA21071@sirena.org.uk>
References: <1302136270-28776-1-git-send-email-sbkim73@samsung.com>
	<1302136270-28776-4-git-send-email-sbkim73@samsung.com>
	<20110407011704.GA21071@sirena.org.uk>
Message-ID: <041801cbf4c8$51ca7390$f55f5ab0$@com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,


On Thu, Apr 07, 2011 at 10:17:10AM +0900, Mark Brown wrote:

> > +config SND_SOC_SAMSUNG_SMDK_WM8580_PCM
> > +	tristate
> > +
> 
> What is the purpose of this variable?  Just the config for the machine
> should be enough.
Ok, I will remove it and use machine config.

> 
> > @@ -1,12 +1,12 @@
> > -# S3c24XX Platform Support
> > +# SAMSUNG Platform Support
> >  snd-soc-s3c24xx-objs := dma.o
> >  snd-soc-s3c24xx-i2s-objs := s3c24xx-i2s.o
> >  snd-soc-s3c2412-i2s-objs := s3c2412-i2s.o
> >  snd-soc-ac97-objs := ac97.o
> >  snd-soc-s3c-i2s-v2-objs := s3c-i2s-v2.o
> >  snd-soc-samsung-spdif-objs := spdif.o
> > -snd-soc-pcm-objs := pcm.o
> > -snd-soc-i2s-objs := i2s.o
> > +snd-soc-samsung-pcm-objs := pcm.o
> > +snd-soc-samsung-i2s-objs := i2s.o
> 
> These changes all look reasonable but they're unrelated to adding the
> machine driver and should be split out.
Ok, I will split out.

> 
> > diff --git a/sound/soc/samsung/pcm.c b/sound/soc/samsung/pcm.c
> > index 38aac7d..9c7e8b4 100644
> > --- a/sound/soc/samsung/pcm.c
> > +++ b/sound/soc/samsung/pcm.c
> > @@ -350,8 +350,8 @@ static int s3c_pcm_set_fmt(struct snd_soc_dai
> *cpu_dai,
> >  	ctl = readl(regs + S3C_PCM_CTL);
> >
> >  	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
> > -	case SND_SOC_DAIFMT_NB_NF:
> > -		/* Nothing to do, NB_NF by default */
> > +	case SND_SOC_DAIFMT_IB_NF:
> > +		/* Nothing to do, IB_NF by default */
> >  		break;
> 
> Similarly here, this is a bug fix so should be merged for 2.6.39.
I will submit another bug fix patch for this.

> 
> > +	smdk_snd_device = platform_device_alloc("soc-audio", -1);
> > +	if (!smdk_snd_device)
> > +		return -ENOMEM;
> 
> Please use snd_soc_register_card() for new machines rather than the
> soc-audio device.  Otherwise the actual driver itself looks good.
Ok I will apply it.

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel at alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel


Thanks and Regards,
SB Kim
