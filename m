From: giulio.benetti@micronovasrl.com (Giulio Benetti)
Date: Wed, 24 Oct 2018 10:42:40 +0200
Subject: [PATCH 1/2] drm/sun4i: hdmi: Fix unitialized variable
In-Reply-To: <20181021163446.29135-1-maxime.ripard@bootlin.com>
References: <20181021163446.29135-1-maxime.ripard@bootlin.com>
Message-ID: <9c27f44f-be09-3349-8aa1-c68cbabe73a0@micronovasrl.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Il 21/10/2018 18:34, Maxime Ripard ha scritto:
> The is_double variable is used to store, and possibly returning to the
> calling function, whether it needs to double the rate of the parent clock
> or not.
> 
> In the case where it does, the variable is affected, but in the case where
> it doesn't we return some uninitialized value. Fix this.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Maxime Ripard <maxime.ripard at bootlin.comReviewed-by: Giulio Benetti <giulio.benetti@micronovasrl.com>

> ---
>   drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
> index 3ecffa52c814..cd2348554bac 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
> @@ -35,7 +35,7 @@ static unsigned long sun4i_tmds_calc_divider(unsigned long rate,
>   {
>   	unsigned long best_rate = 0;
>   	u8 best_m = 0, m;
> -	bool is_double;
> +	bool is_double = false;
>   
>   	for (m = div_offset ?: 1; m < (16 + div_offset); m++) {
>   		u8 d;
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
