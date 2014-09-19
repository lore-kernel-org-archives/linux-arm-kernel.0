From: yingjoe.chen@mediatek.com (Joe.C)
Date: Fri, 19 Sep 2014 21:47:40 +0800
Subject: [PATCH 2/4] ARM: mediatek: Add Pinctrl/GPIO driver for mt8135.
In-Reply-To: <1411127306-13677-3-git-send-email-srv_hongzhou.yang@mediatek.com>
References: <1411127306-13677-1-git-send-email-srv_hongzhou.yang@mediatek.com>
 <1411127306-13677-3-git-send-email-srv_hongzhou.yang@mediatek.com>
Message-ID: <1411134460.27173.8.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-09-19 at 19:48 +0800, srv_hongzhou.yang at mediatek.com wrote:
> +
> +static const struct pinmux_ops mt_pmx_ops = {
> +	.get_functions_count	= mt_pmx_get_funcs_cnt,
> +	.get_function_name	= mt_pmx_get_func_name,
> +	.get_function_groups	= mt_pmx_get_func_groups,
> +	.enable			= mt_pmx_enable,
> +	.disable		= mt_pmx_disable,
> +	.gpio_set_direction	= mt_pmx_gpio_set_direction,
> +};
> +

It seems pinmux_ops.disable is removed in commit commit
2243a87d90b42eb38bc281957df3e57c712b5e56. So this will cause build
error. This should be fixed in next version.

../drivers/pinctrl/mediatek/pinctrl-mtk-common.c:566:2: error: unknown
field 'disable' specified in initializer
../drivers/pinctrl/mediatek/pinctrl-mtk-common.c:566:2: warning:
initialization from incompatible pointer type [enabled by default]
../drivers/pinctrl/mediatek/pinctrl-mtk-common.c:566:2: warning: (near
initialization for 'mt_pmx_ops.gpio_request_enable') [enabled by
default]

Joe.C
