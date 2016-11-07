From: patrice.chotard@st.com (Patrice Chotard)
Date: Mon, 7 Nov 2016 10:05:13 +0100
Subject: [PATCH 1/1] pinctrl: st: st_pctl_dt_parse_groups simplify
 expression
In-Reply-To: <20161105143515.4668-1-xypron.glpk@gmx.de>
References: <20161105143515.4668-1-xypron.glpk@gmx.de>
Message-ID: <1ac9af0e-0a00-757b-6981-0ff9461fbbb3@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/05/2016 03:35 PM, Heinrich Schuchardt wrote:
> for_each_property_of_node(pins, pp) checks that pp is not NULL.
> So there is no need to check it inside the loop.
> 
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  drivers/pinctrl/pinctrl-st.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
> index 8308f15..676efcc 100644
> --- a/drivers/pinctrl/pinctrl-st.c
> +++ b/drivers/pinctrl/pinctrl-st.c
> @@ -1181,7 +1181,7 @@ static int st_pctl_dt_parse_groups(struct device_node *np,
>  		if (!strcmp(pp->name, "name"))
>  			continue;
>  
> -		if (pp  && (pp->length/sizeof(__be32)) >= OF_GPIO_ARGS_MIN) {
> +		if (pp->length / sizeof(__be32) >= OF_GPIO_ARGS_MIN) {
>  			npins++;
>  		} else {
>  			pr_warn("Invalid st,pins in %s node\n", np->name);
> 

Hi Heinrich

Acked-by: Patrice Chotard <patrice.chotard@st.com>

Thanks
