From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 05 Sep 2016 11:33:18 +0200
Subject: [PATCH 3/4] include: dt-bindings: Add more GPIO bank and index
 definition for rockchip pinctrl
In-Reply-To: <1472978130-919-1-git-send-email-andy.yan@rock-chips.com>
References: <1472977937-758-1-git-send-email-andy.yan@rock-chips.com>
 <1472978130-919-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <3544284.90s5nXbktR@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

Am Sonntag, 4. September 2016, 16:35:30 CEST schrieb Andy Yan:
> There are 8 gpio banks on RK3288, so add the missing
> RK_GPIO7 and RK_GPIO8. Also add gpio index definition
> to make it easier to description GPIO in dts.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

I tend to disagree here.

I consider the bank defines RK_GPIOx to be deprecated and highly discourage 
them being used in new boards. They only encode the same number again (2 -> 
RK_GPIO2 etc) and therefore don't bring any useful addition over using the 
bank number directly.

Slightly similar argument for the per-pin defines. While the external pins are 
described in the A/B/C/Dx notation for pinmux purposes, the gpio controllers 
on top use a regular 0-31 numbering. Also you cannot name constants generic 
GPIO_x, simply because that may conflict with other overly generic constant 
names.

So I'm not yet convinced that these improve readability, but they would 
definitly need a RK_* prefix to make them specific.


Heiko

> ---
> 
>  include/dt-bindings/pinctrl/rockchip.h | 35
> ++++++++++++++++++++++++++++++++++ 1 file changed, 35 insertions(+)
> 
> diff --git a/include/dt-bindings/pinctrl/rockchip.h
> b/include/dt-bindings/pinctrl/rockchip.h index 743e66a..fd35350 100644
> --- a/include/dt-bindings/pinctrl/rockchip.h
> +++ b/include/dt-bindings/pinctrl/rockchip.h
> @@ -24,6 +24,41 @@
>  #define RK_GPIO3	3
>  #define RK_GPIO4	4
>  #define RK_GPIO6	6
> +#define RK_GPIO7	7
> +#define RK_GPIO8	8
> +
> +#define GPIO_A0		0
> +#define GPIO_A1		1
> +#define GPIO_A2		2
> +#define GPIO_A3		3
> +#define GPIO_A4		4
> +#define GPIO_A5		5
> +#define GPIO_A6		6
> +#define GPIO_A7		7
> +#define GPIO_B0		8
> +#define GPIO_B1		9
> +#define GPIO_B2		10
> +#define GPIO_B3		11
> +#define GPIO_B4		12
> +#define GPIO_B5		13
> +#define GPIO_B6		14
> +#define GPIO_B7		15
> +#define GPIO_C0		16
> +#define GPIO_C1		17
> +#define GPIO_C2		18
> +#define GPIO_C3		19
> +#define GPIO_C4		20
> +#define GPIO_C5		21
> +#define GPIO_C6		22
> +#define GPIO_C7		23
> +#define GPIO_D0		24
> +#define GPIO_D1		25
> +#define GPIO_D2		26
> +#define GPIO_D3		27
> +#define GPIO_D4		28
> +#define GPIO_D5		29
> +#define GPIO_D6		30
> +#define GPIO_D7		31
> 
>  #define RK_FUNC_GPIO	0
>  #define RK_FUNC_1	1
