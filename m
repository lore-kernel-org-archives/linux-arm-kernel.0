From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 06 Sep 2016 00:10:58 +0200
Subject: [PATCH 3/4] include: dt-bindings: Add more GPIO bank and index
 definition for rockchip pinctrl
In-Reply-To: <0dbac4cd-7f67-5052-16e6-463896bf5929@rock-chips.com>
References: <1472977937-758-1-git-send-email-andy.yan@rock-chips.com>
 <3544284.90s5nXbktR@phil>
 <0dbac4cd-7f67-5052-16e6-463896bf5929@rock-chips.com>
Message-ID: <5785582.C1XOtVbxro@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 5. September 2016, 18:22:46 CEST schrieb Andy Yan:
> Hi Heiko:
> 
> On 2016?09?05? 17:33, Heiko Stuebner wrote:
> > Hi Andy,
> > 
> > Am Sonntag, 4. September 2016, 16:35:30 CEST schrieb Andy Yan:
> >> There are 8 gpio banks on RK3288, so add the missing
> >> RK_GPIO7 and RK_GPIO8. Also add gpio index definition
> >> to make it easier to description GPIO in dts.
> >> 
> >> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> > 
> > I tend to disagree here.
> > 
> > I consider the bank defines RK_GPIOx to be deprecated and highly
> > discourage
> > them being used in new boards. They only encode the same number again (2
> > ->
> > RK_GPIO2 etc) and therefore don't bring any useful addition over using the
> > bank number directly.
> > 
> > Slightly similar argument for the per-pin defines. While the external pins
> > are described in the A/B/C/Dx notation for pinmux purposes, the gpio
> > controllers on top use a regular 0-31 numbering. Also you cannot name
> > constants generic GPIO_x, simply because that may conflict with other
> > overly generic constant names.
> > 
> > So I'm not yet convinced that these improve readability, but they would
> > definitly need a RK_* prefix to make them specific.
> > 
> > 
> > Heiko
> 
>          I consider for a people who doesn't familiar with rockchip
> pinctrl, He
>   may don't know what does these number 2/4/17....stands for in the dts
> like
>   rockchip,pins = <2 17 RK_FUNC_GPIO &pcfg_pull_up>.

That person shouldn't work on devicetrees anyway :-) ... or simply read the 
dt-binding for the pinctrl at first ... which should normally really be the 
first step, otherwise we wouldn't need the binding documentation.

>          But if we use meaningful macro here like : rockchip,pins =
> <RK_GPIO2 RK_GPIO_C0 RK_FUNC_GPIO &pcfg_pull_up>, I think it easier to
> tell people this GPIO is GPIO_C0 of BNAK2.

I definitly don't agree for the gpio-bank number, see above .

> Especially all the GPIOs in rockchip based schematic are described as
> GPIOn_A/B/C/Dx. And it is also easier for people to directly use a macro
> stands for 0~32 than translating A/B/C/Dx from the schematic to 0~32.

But the pins might in fact really be helpful, but definitly need a prefix and 
maybe even distinguish between pin and gpio, aka RK_PIN_A0 etc?


Heiko

> 
> >> ---
> >> 
> >>   include/dt-bindings/pinctrl/rockchip.h | 35
> >> 
> >> ++++++++++++++++++++++++++++++++++ 1 file changed, 35 insertions(+)
> >> 
> >> diff --git a/include/dt-bindings/pinctrl/rockchip.h
> >> b/include/dt-bindings/pinctrl/rockchip.h index 743e66a..fd35350 100644
> >> --- a/include/dt-bindings/pinctrl/rockchip.h
> >> +++ b/include/dt-bindings/pinctrl/rockchip.h
> >> @@ -24,6 +24,41 @@
> >> 
> >>   #define RK_GPIO3	3
> >>   #define RK_GPIO4	4
> >>   #define RK_GPIO6	6
> >> 
> >> +#define RK_GPIO7	7
> >> +#define RK_GPIO8	8
> >> +
> >> +#define GPIO_A0		0
> >> +#define GPIO_A1		1
> >> +#define GPIO_A2		2
> >> +#define GPIO_A3		3
> >> +#define GPIO_A4		4
> >> +#define GPIO_A5		5
> >> +#define GPIO_A6		6
> >> +#define GPIO_A7		7
> >> +#define GPIO_B0		8
> >> +#define GPIO_B1		9
> >> +#define GPIO_B2		10
> >> +#define GPIO_B3		11
> >> +#define GPIO_B4		12
> >> +#define GPIO_B5		13
> >> +#define GPIO_B6		14
> >> +#define GPIO_B7		15
> >> +#define GPIO_C0		16
> >> +#define GPIO_C1		17
> >> +#define GPIO_C2		18
> >> +#define GPIO_C3		19
> >> +#define GPIO_C4		20
> >> +#define GPIO_C5		21
> >> +#define GPIO_C6		22
> >> +#define GPIO_C7		23
> >> +#define GPIO_D0		24
> >> +#define GPIO_D1		25
> >> +#define GPIO_D2		26
> >> +#define GPIO_D3		27
> >> +#define GPIO_D4		28
> >> +#define GPIO_D5		29
> >> +#define GPIO_D6		30
> >> +#define GPIO_D7		31
> >> 
> >>   #define RK_FUNC_GPIO	0
> >>   #define RK_FUNC_1	1
