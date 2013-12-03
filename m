From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 3 Dec 2013 09:59:58 +0000
Subject: [alsa-devel] [PATCH 3/3] ASoC: ux500: Dynamically fill DAI
 driver data on probe
In-Reply-To: <529D9D14.9040109@metafoo.de>
References: <1386007222-10081-1-git-send-email-lee.jones@linaro.org>
 <1386007222-10081-3-git-send-email-lee.jones@linaro.org>
 <529CCD2F.3060206@metafoo.de> <20131203084026.GC11828@lee--X1>
 <529D9D14.9040109@metafoo.de>
Message-ID: <20131203095958.GH11828@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >>[...]
> >>>+void ux500_msp_populate_dai_drv(struct snd_soc_dai_driver *ux500_msp_dai_drv)
> >>>+{
> >>>+	ux500_msp_dai_drv->probe                 = ux500_msp_dai_probe;
> >>>+	ux500_msp_dai_drv->suspend               = NULL;
> >>>+	ux500_msp_dai_drv->resume                = NULL;
> >>>+	ux500_msp_dai_drv->playback.channels_min = UX500_MSP_MIN_CHANNELS;
> >>>+	ux500_msp_dai_drv->playback.channels_max = UX500_MSP_MAX_CHANNELS;
> >>>+	ux500_msp_dai_drv->playback.rates        = UX500_I2S_RATES;
> >>>+	ux500_msp_dai_drv->playback.formats      = UX500_I2S_FORMATS;
> >>>+	ux500_msp_dai_drv->capture.channels_min  = UX500_MSP_MIN_CHANNELS;
> >>>+	ux500_msp_dai_drv->capture.channels_max  = UX500_MSP_MAX_CHANNELS;
> >>>+	ux500_msp_dai_drv->capture.rates         = UX500_I2S_RATES;
> >>>+	ux500_msp_dai_drv->capture.formats       = UX500_I2S_FORMATS;
> >>>+	ux500_msp_dai_drv->ops                   = ux500_msp_dai_ops;
> >>>  };
> >>
> >>You can just use the same static driver for all devices. No need to
> >>dynamically allocate it.
> >
> >How do you mean? Just create a 'static struct' instead?
> 
> Yes.
> 
> static struct snd_soc_dai_driver ux500_msp_dai_driver = {
> 	...
> };

Yes, that's no issue. I was more focused on the reduction of code
than anything else, but that is a better idea.

I'll resubmit.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
