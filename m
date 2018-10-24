From: giulio.benetti@micronovasrl.com (Giulio Benetti)
Date: Wed, 24 Oct 2018 10:43:34 +0200
Subject: [PATCH 2/2] drm/sun4i: hdmi: Fix double flag assignation
In-Reply-To: <20181021163446.29135-2-maxime.ripard@bootlin.com>
References: <20181021163446.29135-1-maxime.ripard@bootlin.com>
 <20181021163446.29135-2-maxime.ripard@bootlin.com>
Message-ID: <41337136-daa0-6773-e5e4-9bea60a14a49@micronovasrl.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Il 21/10/2018 18:34, Maxime Ripard ha scritto:
> The is_double flag is a boolean currently assigned to the value of the d
> variable, that is either 1 or 2. It means that this is_double variable is
> always set to true, even though the initial intent was to have it set to
> true when d is 2.
> 
> Fix this.
> 
> Fixes: 9c5681011a0c ("drm/sun4i: Add HDMI support")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Reviewed-by: Giulio Benetti <giulio.benetti@micronovasrl.com>

> ---
>   drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
> index cd2348554bac..fb985ba1a176 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
> @@ -52,7 +52,7 @@ static unsigned long sun4i_tmds_calc_divider(unsigned long rate,
>   			    (rate - tmp_rate) < (rate - best_rate)) {
>   				best_rate = tmp_rate;
>   				best_m = m;
> -				is_double = d;
> +				is_double = (d == 2) ? true : false;
>   			}
>   		}
>   	}
> 

-- 
Giulio Benetti
CTO

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale ? 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642
