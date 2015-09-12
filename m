From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 12 Sep 2015 12:40:37 +0200
Subject: [PATCH 1/2] pinctrl: rockchip: Define GPIO banks 7 and 8
In-Reply-To: <1442011005-4828-1-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1442011005-4828-1-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <4186674.JafPHeXURU@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sjoerd,

Am Samstag, 12. September 2015, 00:36:44 schrieb Sjoerd Simons:
> Rockchip RK3288 has 9 GPIO banks (0 to 8) add definitions for the last
> two.
> 
> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> ---
> 
>  include/dt-bindings/pinctrl/rockchip.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/dt-bindings/pinctrl/rockchip.h
> b/include/dt-bindings/pinctrl/rockchip.h index 743e66a..efc57cf 100644
> --- a/include/dt-bindings/pinctrl/rockchip.h
> +++ b/include/dt-bindings/pinctrl/rockchip.h
> @@ -24,6 +24,8 @@
>  #define RK_GPIO3	3
>  #define RK_GPIO4	4
>  #define RK_GPIO6	6
> +#define RK_GPIO7	7
> +#define RK_GPIO8	8
> 
>  #define RK_FUNC_GPIO	0
>  #define RK_FUNC_1	1

I'm actually not sure about these. In retrospect the RK_GPIOx -> x defines do 
not provide any additional value compared to just having the actual value in 
the pinctrl-nodes, so we phased them out largely for the rk3288 boards.

While looking through some boards, I saw that some slipped in for stuff that 
gets copy'n'paste treatment most of the time, but generally we're only using 
the real numbers on boards - and I'd like to keep it that way and phase out 
the RK_GPIOx constants in new boards.


Heiko
