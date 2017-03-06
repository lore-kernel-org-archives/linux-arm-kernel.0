From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 6 Mar 2017 11:42:04 -0300
Subject: [PATCH v10 3/3] arm64: dts: exynos: Add support for S6E3HA2 panel
 device on TM2 board
In-Reply-To: <5be15c1c-ba4c-94d9-30be-8d161e9be7b3@samsung.com>
References: <1487574582-15746-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170220071001epcas1p3c2b32665942ba55c3ed4e06d2c66d661@epcas1p3.samsung.com>
 <5be15c1c-ba4c-94d9-30be-8d161e9be7b3@samsung.com>
Message-ID: <7fb60ffc-086f-9e68-137a-a8aa1411ba40@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Hoegeun,

On 02/21/2017 10:09 PM, Hoegeun Kwon wrote:
> From: Hyungwon Hwang <human.hwang@samsung.com>
> 
> This patch add the panel device tree node for S6E3HA2 display
> controller to TM2 dts.
> 
> Signed-off-by: Hyungwon Hwang <human.hwang@samsung.com>
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
> Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos5433-tm2.dts | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts b/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
> index dea0a6f..db3fed2 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
> +++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
> @@ -52,6 +52,18 @@
>      assigned-clock-rates = <250000000>, <400000000>;
>  };

I would add a line here.

>  +&dsi {
> +    panel at 0 {
> +        compatible = "samsung,s6e3ha2";
> +        reg = <0>;
> +        vdd3-supply = <&ldo27_reg>;
> +        vci-supply = <&ldo28_reg>;
> +        reset-gpios = <&gpg0 0 GPIO_ACTIVE_LOW>;
> +        enable-gpios = <&gpf1 5 GPIO_ACTIVE_HIGH>;
> +        te-gpios = <&gpf1 3 GPIO_ACTIVE_HIGH>;
> +    };
> +};
> +

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
