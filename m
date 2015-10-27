From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Tue, 27 Oct 2015 08:27:05 +0530
Subject: [PATCH 1/4] ARM: dts: Add SROMc to Exynos 5410
In-Reply-To: <185cfa03e31cee4187492e0b9b0050e4b6f1a8f9.1445859834.git.p.fedin@samsung.com>
References: <cover.1445859834.git.p.fedin@samsung.com>
 <185cfa03e31cee4187492e0b9b0050e4b6f1a8f9.1445859834.git.p.fedin@samsung.com>
Message-ID: <562EE801.4000906@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

On Monday 26 October 2015 05:17 PM, Pavel Fedin wrote:
> This machine uses own SoC device tree file, add missing part.
>
> Signed-off-by: Pavel Fedin <p.fedin@samsung.com>
> ---
>   arch/arm/boot/dts/exynos5410.dtsi | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
> index 4603356..91dd302 100644
> --- a/arch/arm/boot/dts/exynos5410.dtsi
> +++ b/arch/arm/boot/dts/exynos5410.dtsi
> @@ -101,6 +101,11 @@
>   			reg = <0x10000000 0x100>;
>   		};
>
> +		sromc_0: sromc at 12250000 {

Why sromc_0? Does this SoC have more than one srom controllers?

> +			compatible = "samsung,exynos-srom";
> +			reg = <0x12250000 0x10>;
> +		};
> +
>   		pmu_system_controller: system-controller at 10040000 {
>   			compatible = "samsung,exynos5410-pmu", "syscon";
>   			reg = <0x10040000 0x5000>;
>

Thanks,
Pankaj Dubey
