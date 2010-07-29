From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Thu, 29 Jul 2010 17:23:53 +0400
Subject: [PATCH v3] video/imxfb.c: allow usage without
	BACKLIGHT_CLASS_DEVICE
In-Reply-To: <1280408618-21364-1-git-send-email-eric@eukrea.com>
References: <20100729124534.GB6268@pengutronix.de>
	<1280408618-21364-1-git-send-email-eric@eukrea.com>
Message-ID: <4C5180E9.8070203@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Eric B?nard wrote:

> Signed-off-by: Eric B?nard <eric@eukrea.com>
[...]
> diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
> index 43f0639..2f9b7e3 100644
> --- a/drivers/video/imxfb.c
> +++ b/drivers/video/imxfb.c
> @@ -40,6 +40,12 @@
>   */
>  #define DEBUG_VAR 1
>  
> +#if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) || \
> +	(defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE) && \
> +		defined(CONFIG_FB_IMX__MODULE))

    Are you sure there should be two underscores before MODULE?

WBR, Sergei
