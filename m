From: LW@KARO-electronics.de (=?iso-8859-15?Q?Lothar_Wa=DFmann?=)
Date: Thu, 29 Jul 2010 15:37:16 +0200
Subject: [PATCH v3] video/imxfb.c: allow usage without
	BACKLIGHT_CLASS_DEVICE
In-Reply-To: <1280408618-21364-1-git-send-email-eric@eukrea.com>
References: <20100729124534.GB6268@pengutronix.de>
	<1280408618-21364-1-git-send-email-eric@eukrea.com>
Message-ID: <19537.33804.34059.293152@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric B?nard writes:
> Signed-off-by: Eric B?nard <eric@eukrea.com>
> ---
> v3:	handle CONFIG_BACKLIGHT_CLASS_DEVICE=m & CONFIG_FB_IMX=y case as per
> 	suggested by Uwe
> v2:	handle CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE
> 
>  drivers/video/imxfb.c |   19 +++++++++++++++++--
>  1 files changed, 17 insertions(+), 2 deletions(-)
> 
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
                                     ^^
should be just one '_'.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
