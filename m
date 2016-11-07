From: patrice.chotard@st.com (Patrice Chotard)
Date: Mon, 7 Nov 2016 10:02:50 +0100
Subject: [PATCH 1/1] pinctrl: st: st_pinconf_dbg_show wrong format string
In-Reply-To: <20161105142515.4377-1-xypron.glpk@gmx.de>
References: <20161105142515.4377-1-xypron.glpk@gmx.de>
Message-ID: <8069c787-a934-ba1f-0284-1a28f170ef6d@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/05/2016 03:25 PM, Heinrich Schuchardt wrote:
> function is defined as unsigned int.
> So we need %u to print it.
> 
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  drivers/pinctrl/pinctrl-st.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
> index b7bb371..8308f15 100644
> --- a/drivers/pinctrl/pinctrl-st.c
> +++ b/drivers/pinctrl/pinctrl-st.c
> @@ -1006,7 +1006,7 @@ static void st_pinconf_dbg_show(struct pinctrl_dev *pctldev,
>  
>  	function = st_pctl_get_pin_function(pc, offset);
>  	if (function)
> -		snprintf(f, 10, "Alt Fn %d", function);
> +		snprintf(f, 10, "Alt Fn %u", function);
>  	else
>  		snprintf(f, 5, "GPIO");
>  
> 


Hi Heinrich

Acked-by: Patrice Chotard <patrice.chotard@st.com>

Thanks
