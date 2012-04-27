From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 27 Apr 2012 11:05:08 +0200
Subject: [PATCH 06/17] ARM: imx: use machine specific hook for late init
In-Reply-To: <1335454725-13089-7-git-send-email-shawn.guo@linaro.org>
References: <1335454725-13089-1-git-send-email-shawn.guo@linaro.org>
 <1335454725-13089-7-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120427090508.GD17184@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2012 at 11:38:34PM +0800, Shawn Guo wrote:
> Cc: Sascha Hauer <kernel@pengutronix.de>
> -static int __init eet_init_devices(void)
> +int __init pcm037_eet_init_devices(void)
>  {
> -	if (!machine_is_pcm037() || pcm037_variant() != PCM037_EET)
> -		return 0;

The pcm037_variant() != PCM037_EET gets lost here.

Otherwise looks good.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
