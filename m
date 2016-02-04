From: hongzhou.yang@mediatek.com (Hongzhou Yang)
Date: Wed, 3 Feb 2016 19:03:35 -0800
Subject: [PATCH 1/2] pinctrl: mediatek: fix direction control issue
In-Reply-To: <1454462686-770-2-git-send-email-biao.huang@mediatek.com>
References: <1454462686-770-1-git-send-email-biao.huang@mediatek.com>
 <1454462686-770-2-git-send-email-biao.huang@mediatek.com>
Message-ID: <1454555015.4618.10.camel@mussux00>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-02-03 at 09:24 +0800, Biao Huang wrote:
> Since input-enable/disable and input-schmitt-enable/disable are
> workable when gpio direction is input, so add direction setting
> when do input-enable/disable and input-schmitt-enable/disable
> properties.
> 
> Signed-off-by: Biao Huang <biao.huang@mediatek.com>
> ---
>  drivers/pinctrl/mediatek/pinctrl-mtk-common.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> index 8cac73d..6eb01c9 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> @@ -352,6 +352,7 @@ static int mtk_pconf_parse_conf(struct pinctrl_dev *pctldev,
>  		ret = mtk_pconf_set_pull_select(pctl, pin, true, false, arg);
>  		break;
>  	case PIN_CONFIG_INPUT_ENABLE:
> +		mtk_pmx_gpio_set_direction(pctldev, NULL, pin, true);
>  		ret = mtk_pconf_set_ies_smt(pctl, pin, arg, param);

Hi Linus,

>From pinctrl-bindings.txt, 'input-enable' property defined as following:
input-enable        - enable input on pin (no effect on output)

Since input enable and input direction are two different settings on our
SOC, could you tell me the exact meaning of this property? Input enable
only? Or set input direction at the same time?

Thanks,
Hongzhou
