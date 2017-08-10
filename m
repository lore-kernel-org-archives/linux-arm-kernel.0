From: patrice.chotard@st.com (Patrice CHOTARD)
Date: Thu, 10 Aug 2017 11:03:42 +0000
Subject: [PATCH 04/17] pinctrl: st: constify pinconf_ops, pinctrl_ops, and
 pinmux_ops structures
In-Reply-To: <1502359589-15970-5-git-send-email-Julia.Lawall@lip6.fr>
References: <1502359589-15970-1-git-send-email-Julia.Lawall@lip6.fr>
 <1502359589-15970-5-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <ff3ddade-259e-0638-b066-cb20c9161cb7@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Julia

On 08/10/2017 12:06 PM, Julia Lawall wrote:
> These structures are only stored in fields of a pinctrl_desc
> structure (confops, pctlops, and pmxops) that are const. Make the
> structures const as well.
> 
> Done with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> ---
>   drivers/pinctrl/pinctrl-st.c |    6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
> index 7ac8b1e..aed8006 100644
> --- a/drivers/pinctrl/pinctrl-st.c
> +++ b/drivers/pinctrl/pinctrl-st.c
> @@ -861,7 +861,7 @@ static void st_pctl_dt_free_map(struct pinctrl_dev *pctldev,
>   {
>   }
>   
> -static struct pinctrl_ops st_pctlops = {
> +static const struct pinctrl_ops st_pctlops = {
>   	.get_groups_count	= st_pctl_get_groups_count,
>   	.get_group_pins		= st_pctl_get_group_pins,
>   	.get_group_name		= st_pctl_get_group_name,
> @@ -928,7 +928,7 @@ static int st_pmx_set_gpio_direction(struct pinctrl_dev *pctldev,
>   	return 0;
>   }
>   
> -static struct pinmux_ops st_pmxops = {
> +static const struct pinmux_ops st_pmxops = {
>   	.get_functions_count	= st_pmx_get_funcs_count,
>   	.get_function_name	= st_pmx_get_fname,
>   	.get_function_groups	= st_pmx_get_groups,
> @@ -1025,7 +1025,7 @@ static void st_pinconf_dbg_show(struct pinctrl_dev *pctldev,
>   		ST_PINCONF_UNPACK_RT_DELAY(config));
>   }
>   
> -static struct pinconf_ops st_confops = {
> +static const struct pinconf_ops st_confops = {
>   	.pin_config_get		= st_pinconf_get,
>   	.pin_config_set		= st_pinconf_set,
>   	.pin_config_dbg_show	= st_pinconf_dbg_show,
> 

Acked-by: Patrice Chotard <patrice.chotard@st.com>

Thanks
