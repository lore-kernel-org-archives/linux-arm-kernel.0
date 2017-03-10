From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Sat, 11 Mar 2017 03:28:34 +0800
Subject: [PATCH v2 09/11] ARM: dtsi: sun8i: a33: add thermal sensor
In-Reply-To: <20170310103921.19469-10-quentin.schulz@free-electrons.com>
References: <20170310103921.19469-1-quentin.schulz@free-electrons.com>
 <20170310103921.19469-10-quentin.schulz@free-electrons.com>
Message-ID: <3181631489174114@web31g.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



10.03.2017, 18:42, "Quentin Schulz" <quentin.schulz@free-electrons.com>:
> This adds the DT node for the thermal sensor present in the Allwinner
> A33 GPADC.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
> ?arch/arm/boot/dts/sun8i-a33.dtsi | 12 ++++++++++++
> ?1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
> index ba87a9e..704f2b0 100644
> --- a/arch/arm/boot/dts/sun8i-a33.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a33.dtsi
> @@ -278,6 +278,13 @@
> ?????????????????????????status = "disabled";
> ?????????????????};
>
> + rtp: rtp at 01c25000 {
> + compatible = "allwinner,sun8i-a33-gpadc-iio";
> + reg = <0x01c25000 0x100>;
> + #thermal-sensor-cells = <0>;
> + #io-channel-cells = <0>;
> + };

As I said, it's not a "rtp" (Resistive touch panel).

> +
> ?????????????????fe0: display-frontend at 01e00000 {
> ?????????????????????????compatible = "allwinner,sun8i-a33-display-frontend";
> ?????????????????????????reg = <0x01e00000 0x20000>;
> @@ -388,6 +395,11 @@
> ?????????????????????????};
> ?????????????????};
> ?????????};
> +
> + iio-hwmon {
> + compatible = "iio-hwmon";
> + io-channels = <&rtp>;
> + };
> ?};
>
> ?&ccu {
> --
> 2.9.3
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
