From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 17 Jan 2017 15:12:28 +0900
Subject: [PATCH v7 3/3] arm64: dts: exynos: Add tm2 touchkey node
In-Reply-To: <1484632479-3111-4-git-send-email-jcsing.lee@samsung.com>
References: <1484632479-3111-1-git-send-email-jcsing.lee@samsung.com>
 <CGME20170117055444epcas1p430376a7c03940ded299e374367170b03@epcas1p4.samsung.com>
 <1484632479-3111-4-git-send-email-jcsing.lee@samsung.com>
Message-ID: <587DB5CC.4090909@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I tested this patch on v6[1] and replied it.
But, this version is missing the my tested-by and reviewed-by tag.
[1] https://patchwork.kernel.org/patch/9504139/

So, I add my reviewed-by and tested-by tag again.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>


On 2017? 01? 17? 14:54, Jaechul Lee wrote:
> Add DT node support for TM2 touchkey device.
> 
> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
> Signed-off-by: Jaechul Lee <jcsing.lee@samsung.com>
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos5433-tm2.dts | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts b/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
> index 2449266..ddba2f8 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
> +++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
> @@ -18,6 +18,19 @@
>  	compatible = "samsung,tm2", "samsung,exynos5433";
>  };
>  
> +&hsi2c_9 {
> +	status = "okay";
> +
> +	touchkey at 20 {
> +		compatible = "cypress,tm2-touchkey";
> +		reg = <0x20>;
> +		interrupt-parent = <&gpa3>;
> +		interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
> +		vcc-supply = <&ldo32_reg>;
> +		vdd-supply = <&ldo33_reg>;
> +	};
> +};
> +
>  &ldo31_reg {
>  	regulator-name = "TSP_VDD_1.85V_AP";
>  	regulator-min-microvolt = <1850000>;
> 


-- 
Best Regards,
Chanwoo Choi
S/W Center, Samsung Electronics
