From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 17 May 2013 12:51:17 +0200
Subject: [PATCH 2/3] staging: drm/imx: fix spelling error for vsync flag
 config
In-Reply-To: <1368782393-9660-3-git-send-email-list-09_linuc_arm@tqsc.de>
References: <1368782393-9660-1-git-send-email-list-09_linuc_arm@tqsc.de>
 <1368782393-9660-3-git-send-email-list-09_linuc_arm@tqsc.de>
Message-ID: <1368787877.4011.7.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 17.05.2013, 11:19 +0200 schrieb Markus Niebel:
> From: Markus Niebel <Markus.Niebel@tqs.de>
> 
> partial fix of changes from
> "staging: drm/imx: Add support for VGA via TVE on i.MX53"
> 
> Have to check for vsync_pin instead of hsync_pin to set Vsync_pol.
> 
> Signed-off-by: Markus Niebel <Markus.Niebel@tqs.de>
> ---
>  drivers/staging/imx-drm/ipu-v3/ipu-di.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-di.c b/drivers/staging/imx-drm/ipu-v3/ipu-di.c
> index 19d777e..e7b9c98 100644
> --- a/drivers/staging/imx-drm/ipu-v3/ipu-di.c
> +++ b/drivers/staging/imx-drm/ipu-v3/ipu-di.c
> @@ -614,11 +614,11 @@ int ipu_di_init_sync_panel(struct ipu_di *di, struct ipu_di_signal_cfg *sig)
>  				di_gen |= DI_GEN_POLARITY_7;
>  		}
>  		if (sig->Vsync_pol) {
> -			if (sig->hsync_pin == 3)
> +			if (sig->vsync_pin == 3)
>  				di_gen |= DI_GEN_POLARITY_3;
> -			else if (sig->hsync_pin == 6)
> +			else if (sig->vsync_pin == 6)
>  				di_gen |= DI_GEN_POLARITY_6;
> -			else if (sig->hsync_pin == 8)
> +			else if (sig->vsync_pin == 8)
>  				di_gen |= DI_GEN_POLARITY_8;
>  		}
>  	}

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
