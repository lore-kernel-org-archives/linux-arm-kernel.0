From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 29 Jul 2010 11:11:38 +0200
Subject: [PATCH] video/imxfb.c: allow usage without BACKLIGHT_CLASS_DEVICE
In-Reply-To: <1280392978-25405-1-git-send-email-eric@eukrea.com>
References: <20100729051647.GA11268@pengutronix.de>
	<1280392978-25405-1-git-send-email-eric@eukrea.com>
Message-ID: <20100729091138.GA6268@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 29, 2010 at 10:42:58AM +0200, Eric B?nard wrote:
> Signed-off-by: Eric B?nard <eric@eukrea.com>
> ---
>  drivers/video/imxfb.c |   13 +++++++++++--
>  1 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
> index 43f0639..0c2fb4d 100644
> --- a/drivers/video/imxfb.c
> +++ b/drivers/video/imxfb.c
> @@ -175,7 +175,9 @@ struct imxfb_info {
>  
>  	struct imx_fb_videomode *mode;
>  	int			num_modes;
> +#ifdef CONFIG_BACKLIGHT_CLASS_DEVICE
>  	struct backlight_device *bl;
> +#endif
I'm always unsure about these .._MODULE symbols.  If imxfb and backlight
support both are compiled modular, is backlight support picked up if
#ifdef CONFIG_BACKLIGHT_CLASS_DEVICE is used to guard it?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
