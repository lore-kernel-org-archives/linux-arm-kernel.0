From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 16 Mar 2017 09:02:47 +0100
Subject: [PATCH v1 1/7] include: dt-bindings: Add pin function index
 definition for rockchip pinctrl
In-Reply-To: <1489572237-6649-2-git-send-email-cl@rock-chips.com>
References: <1489572237-6649-1-git-send-email-cl@rock-chips.com>
 <1489572237-6649-2-git-send-email-cl@rock-chips.com>
Message-ID: <3841077.a8qRkotiEM@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Mittwoch, 15. M?rz 2017, 18:03:51 CET schrieb cl at rock-chips.com:
> From: Chen Liang <cl@rock-chips.com>
> 
> The rk3328 soc need more pin function index for pinctrl.
> 
> Signed-off-by: Chen Liang <cl@rock-chips.com>
> ---
>  include/dt-bindings/pinctrl/rockchip.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/dt-bindings/pinctrl/rockchip.h
> b/include/dt-bindings/pinctrl/rockchip.h index aaec8ba..bc2b6af 100644
> --- a/include/dt-bindings/pinctrl/rockchip.h
> +++ b/include/dt-bindings/pinctrl/rockchip.h
> @@ -63,5 +63,8 @@
>  #define RK_FUNC_2	2
>  #define RK_FUNC_3	3
>  #define RK_FUNC_4	4
> +#define RK_FUNC_5	5
> +#define RK_FUNC_6	6
> +#define RK_FUNC_7	7

please don't amend that function list anymore.

Only RK_FUNC_GPIO serves a real purpose but having constants FUNC_7 mapping 
simply to 7 does not help understand things better, so it's way easier to just 
have "7" as function in pinctrl entries in the devicetree.

That list is mainly a remnant to keep compatibility with old devicetrees and I 
guess I should add a deprecated notice at some point :-) .


Heiko
