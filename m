From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 5 Jan 2017 20:41:40 +0200
Subject: [PATCH v2 4/4] arm64: dts: exynos: Add tm2 touchkey node
In-Reply-To: <1483604833-29746-5-git-send-email-jcsing.lee@samsung.com>
References: <1483604833-29746-1-git-send-email-jcsing.lee@samsung.com>
 <CGME20170105082716epcas1p100f48f22d5ff0bad7776f6d7b444daf3@epcas1p1.samsung.com>
 <1483604833-29746-5-git-send-email-jcsing.lee@samsung.com>
Message-ID: <20170105184140.tongd3evzm57qkps@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 05, 2017 at 05:27:13PM +0900, Jaechul Lee wrote:
> Add DT node support for TM2 touchkey device.
> 
> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
> Signed-off-by: Jaechul Lee <jcsing.lee@samsung.com>
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Although I said the patch looks correct, it was not an explicit Review
(and we have a quite serious "Reviewer's statement of oversight") so my
tag should not be added.

No harm was done, but I prefer clearly and explicitly given tags.

Best regards,
Krzysztof

> ---
>  arch/arm64/boot/dts/exynos/exynos5433-tm2.dts | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts b/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
> index aa8584a..dad6fb8 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
> +++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
> @@ -17,3 +17,16 @@
>  	model = "Samsung TM2 board";
>  	compatible = "samsung,tm2", "samsung,exynos5433";
>  };
> +
> +&hsi2c_9 {
> +	status = "okay";
> +
> +	touchkey at 20 {
> +		compatible = "samsung,tm2-touchkey";
> +		reg = <0x20>;
> +		interrupt-parent = <&gpa3>;
> +		interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
> +		vcc-supply = <&ldo32_reg>;
> +		vdd-supply = <&ldo33_reg>;
> +	};
> +};
> -- 
> 2.7.4
> 
