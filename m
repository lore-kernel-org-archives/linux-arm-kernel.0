From: vz@mleia.com (Vladimir Zapolskiy)
Date: Fri, 17 Aug 2018 18:32:11 +0300
Subject: [PATCH] pinctrl: lpc18xx: mark expected switch fall-throughs
In-Reply-To: <20180815171035.GA17360@embeddedor.com>
References: <20180815171035.GA17360@embeddedor.com>
Message-ID: <57a0c7c7-e2a2-3586-b683-f854120eeee7@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/15/2018 08:10 PM, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Addresses-Coverity-ID: 1292308 ("Missing break in switch")
> Addresses-Coverity-ID: 1292309 ("Missing break in switch")
> Addresses-Coverity-ID: 1309546 ("Missing break in switch")
> Addresses-Coverity-ID: 1357369 ("Missing break in switch")
> Addresses-Coverity-ID: 1357389 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/pinctrl/pinctrl-lpc18xx.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pinctrl/pinctrl-lpc18xx.c b/drivers/pinctrl/pinctrl-lpc18xx.c
> index 190f17e..a14bc5e 100644
> --- a/drivers/pinctrl/pinctrl-lpc18xx.c
> +++ b/drivers/pinctrl/pinctrl-lpc18xx.c
> @@ -844,8 +844,11 @@ static int lpc18xx_pconf_get_pin(struct pinctrl_dev *pctldev, unsigned param,
>  		*arg = (reg & LPC18XX_SCU_PIN_EHD_MASK) >> LPC18XX_SCU_PIN_EHD_POS;
>  		switch (*arg) {
>  		case 3: *arg += 5;
> +			/* fall through */
>  		case 2: *arg += 5;
> +			/* fall through */
>  		case 1: *arg += 3;
> +			/* fall through */
>  		case 0: *arg += 4;
>  		}
>  		break;
> @@ -1060,8 +1063,11 @@ static int lpc18xx_pconf_set_pin(struct pinctrl_dev *pctldev, unsigned param,
>  
>  		switch (param_val) {
>  		case 20: param_val -= 5;
> +			 /* fall through */
>  		case 14: param_val -= 5;
> +			 /* fall through */
>  		case  8: param_val -= 3;
> +			 /* fall through */
>  		case  4: param_val -= 4;
>  			 break;
>  		default:
> 

The code snippets are about a mind-blowing hyper-optimization, but I took
it as a chance to verify the correctness, and there are no issues found.

Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>

--
Best wishes,
Vladimir
