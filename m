From: B47053@freescale.com (Xiubo Li-B47053)
Date: Tue, 29 Oct 2013 04:00:57 +0000
Subject: [PATCHv1 1/8] ALSA: Add SAI SoC Digital Audio Interface driver.
In-Reply-To: <20131024110543.GA18506@sirena.org.uk>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-2-git-send-email-Li.Xiubo@freescale.com>
 <20131024110543.GA18506@sirena.org.uk>
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F8286BDB5@039-SN2MPN1-013.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > +static struct snd_pcm_hardware snd_fsl_hardware = {
> > +	.info = SNDRV_PCM_INFO_INTERLEAVED |
> > +		SNDRV_PCM_INFO_BLOCK_TRANSFER |
> > +		SNDRV_PCM_INFO_MMAP |
> > +		SNDRV_PCM_INFO_MMAP_VALID |
> > +		SNDRV_PCM_INFO_PAUSE |
> > +		SNDRV_PCM_INFO_RESUME,
> > +	.formats = SNDRV_PCM_FMTBIT_S16_LE,
> > +	.rate_min = 8000,
> > +	.channels_min = 2,
> > +	.channels_max = 2,
> > +	.buffer_bytes_max = FSL_SAI_DMABUF_SIZE,
> > +	.period_bytes_min = 4096,
> > +	.period_bytes_max = FSL_SAI_DMABUF_SIZE / TCD_NUMBER,
> > +	.periods_min = TCD_NUMBER,
> > +	.periods_max = TCD_NUMBER,
> > +	.fifo_size = 0,
> > +};
> 
> There's a patch in -next that lets the generic dmaengine code figure out
> some settings from the dmacontroller rather than requiring the driver to
> explicitly provide configuration - it's "ASoC: dmaengine-pcm: Provide
> default config".  Please update your driver to use this, or let's work
> out what it doesn't do any try to fix it.
> 

I couldn't find the patch in the next and other trees.
Does this patch has been submitted to the -next tree ?
Or could you tell me how to find the patch please?

Thanks very much.
