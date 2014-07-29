From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 30 Jul 2014 08:01:24 +0900
Subject: [PATCH] ARM: dts: smdk5250: Specify MAX77686 pmic interrupt
In-Reply-To: <1406608029-8538-1-git-send-email-thomas.ab@samsung.com>
References: <1406608029-8538-1-git-send-email-thomas.ab@samsung.com>
Message-ID: <53D827C4.1000708@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/29/14 13:27, Thomas Abraham wrote:
> The IRQB interrupt pin of MAX77686 PMIC is connected to GPX3[2] pin of
> Exynos5250 on the Exynos5250 SMDK board. Specify this connection using
> interrupts property for the max77686 pmic node.
>
> Signed-off-by: Thomas Abraham<thomas.ab@samsung.com>
> ---
>   arch/arm/boot/dts/exynos5250-smdk5250.dts |    2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> index 695f5ad..cf38808 100644
> --- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
> +++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> @@ -50,6 +50,8 @@
>   		max77686 at 09 {
>   			compatible = "maxim,max77686";
>   			reg =<0x09>;
> +			interrupt-parent =<&gpx3>;
> +			interrupts =<2 0>;
>
>   			voltage-regulators {
>   				ldo1_reg: LDO1 {

Applied, thanks.

- Kukjin
