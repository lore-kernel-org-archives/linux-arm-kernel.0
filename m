From: dev@lynxeye.de (Lucas Stach)
Date: Fri, 13 May 2016 09:25:31 +0200
Subject: [PATCH] ARM: tegra: beaver: allow SD card voltage to be changed
In-Reply-To: <1456779678-20173-1-git-send-email-dev@lynxeye.de>
References: <1456779678-20173-1-git-send-email-dev@lynxeye.de>
Message-ID: <1463124331.2459.0.camel@lynxeye.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 29.02.2016, 22:01 +0100 schrieb Lucas Stach:
> This allows to switch the card signal voltage level to 1.8V,
> which is needed for any ultra high speed modes to work.
> 
> Signed-off-by: Lucas Stach <dev@lynxeye.de>
> ---
> This needs the SDMMC memcomp pad calibration patches I just
> sent out to be applied, otherwise the card voltage change will
> fail with a message in the kernel log and a fall back to
> high speed operation.

The patches this one depends on have been applied for some time now.
Please pick up this patch.

Thanks,
Lucas
> ---
> ?arch/arm/boot/dts/tegra30-beaver.dts | 3 ++-
> ?1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/tegra30-beaver.dts
> b/arch/arm/boot/dts/tegra30-beaver.dts
> index 1daed40..6b237f2 100644
> --- a/arch/arm/boot/dts/tegra30-beaver.dts
> +++ b/arch/arm/boot/dts/tegra30-beaver.dts
> @@ -1848,7 +1848,7 @@
> ?
> ?				ldo5_reg: ldo5 {
> ?					regulator-name =
> "vddio_sdmmc,avdd_vdac";
> -					regulator-min-microvolt =
> <3300000>;
> +					regulator-min-microvolt =
> <1800000>;
> ?					regulator-max-microvolt =
> <3300000>;
> ?					regulator-always-on;
> ?				};
> @@ -1919,6 +1919,7 @@
> ?
> ?	sdhci at 78000000 {
> ?		status = "okay";
> +		vqmmc-supply = <&ldo5_reg>;
> ?		cd-gpios = <&gpio TEGRA_GPIO(I, 5) GPIO_ACTIVE_LOW>;
> ?		wp-gpios = <&gpio TEGRA_GPIO(T, 3)
> GPIO_ACTIVE_HIGH>;
> ?		power-gpios = <&gpio TEGRA_GPIO(D, 7)
> GPIO_ACTIVE_HIGH>;
