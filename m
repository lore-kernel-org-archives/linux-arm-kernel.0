From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 10 Aug 2017 15:39:15 +0300
Subject: [PATCH 07/17] pinctrl: digicolor: constify pinconf_ops,
 pinctrl_ops, and pinmux_ops structures
In-Reply-To: <1502359589-15970-8-git-send-email-Julia.Lawall@lip6.fr>
References: <1502359589-15970-1-git-send-email-Julia.Lawall@lip6.fr>
 <1502359589-15970-8-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <20170810123915.3mqvg4f3qqx4e45f@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Julia,

On Thu, Aug 10, 2017 at 12:06:19PM +0200, Julia Lawall wrote:
> These structures are only stored in fields of a pinctrl_desc
> structure (pctlops and pmxops) that are const. Make the
> structures const as well.
> 
> Done with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Acked-by: Baruch Siach <baruch@tkos.co.il>

Thanks,
baruch

> ---
>  drivers/pinctrl/pinctrl-digicolor.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-digicolor.c b/drivers/pinctrl/pinctrl-digicolor.c
> index 639a57e..ce269ce 100644
> --- a/drivers/pinctrl/pinctrl-digicolor.c
> +++ b/drivers/pinctrl/pinctrl-digicolor.c
> @@ -79,7 +79,7 @@ static int dc_get_group_pins(struct pinctrl_dev *pctldev, unsigned selector,
>  	return 0;
>  }
>  
> -static struct pinctrl_ops dc_pinctrl_ops = {
> +static const struct pinctrl_ops dc_pinctrl_ops = {
>  	.get_groups_count	= dc_get_groups_count,
>  	.get_group_name		= dc_get_group_name,
>  	.get_group_pins		= dc_get_group_pins,
> @@ -161,7 +161,7 @@ static int dc_pmx_request_gpio(struct pinctrl_dev *pcdev,
>  	return 0;
>  }
>  
> -static struct pinmux_ops dc_pmxops = {
> +static const struct pinmux_ops dc_pmxops = {
>  	.get_functions_count	= dc_get_functions_count,
>  	.get_function_name	= dc_get_fname,
>  	.get_function_groups	= dc_get_groups,

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
