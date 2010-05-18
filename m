From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Tue, 18 May 2010 10:13:31 +0200
Subject: [PATCH v2 3/9] ARM: SAMSUNG: Implements cfg_gpio function for
	Samsung touchscreen
In-Reply-To: <1273756032-3098-1-git-send-email-kgene.kim@samsung.com> (Kukjin
	Kim's message of "Thu\, 13 May 2010 22\:07\:12 +0900")
References: <1273756032-3098-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <87r5l96310.fsf@lechat.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin Kim <kgene.kim@samsung.com> writes:

Hi,

[...]

> +
> +/**
> + * s3c24xx_ts_cfg_gpio - configure gpio for s3c2410 systems
> + *
> + * Configure the GPIO for the S3C2410 system, where we have external FETs
> + * connected to the device (later systems such as the S3C2440 integrate
> + * these into the device).
> + */
> +void s3c24xx_ts_cfg_gpio(struct platform_device *dev)
> +{
> +	s3c2410_gpio_cfgpin(S3C2410_GPG(12), S3C2410_GPG12_XMON);
> +	s3c2410_gpio_cfgpin(S3C2410_GPG(13), S3C2410_GPG13_nXPON);
> +	s3c2410_gpio_cfgpin(S3C2410_GPG(14), S3C2410_GPG14_YMON);
> +	s3c2410_gpio_cfgpin(S3C2410_GPG(15), S3C2410_GPG15_nYPON);
> +}

hmm... thinking more about this, why don't you put that in the
arch/arm/plat-s3c24xx/devs.c file and then set the cfg_gpio hook in
s3c24xx_ts_set_platdata() for 2410 platforms ? 
This should be smaller change and will set it for all s3c2410 platforms
using the touchscreen once for all and "hide" it  instead of having to
set it in all machine files using the touchscreen.

Arnaud
