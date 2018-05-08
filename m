From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 8 May 2018 11:06:44 -0300
Subject: [PATCH] arm: dts: imx: fix IPU OF graph endpoint node names
In-Reply-To: <20180508135930.5768-2-robh@kernel.org>
References: <20180508135930.5768-1-robh@kernel.org>
 <20180508135930.5768-2-robh@kernel.org>
Message-ID: <CAOMZO5A+7YW89E5PEo6841hk8GQUr2k7D+xWPGb1iqvpD096Rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Tue, May 8, 2018 at 10:59 AM, Rob Herring <robh@kernel.org> wrote:

> diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
> index 18b65052553d..654cf2c9b073 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
> @@ -379,9 +379,6 @@
>                 powerdown-gpios = <&gpio6 9 GPIO_ACTIVE_HIGH>; /* NANDF_WP_B */
>
>                 port {
> -                       #address-cells = <1>;
> -                       #size-cells = <0>;
> -
>                         ov5640_to_mipi_csi2: endpoint {
>                                 remote-endpoint = <&mipi_csi2_in>;
>                                 clock-lanes = <0>;
> diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> index f019f9900369..c2de2250718c 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> @@ -294,9 +294,6 @@
>                 reset-gpios = <&gpio1 20 GPIO_ACTIVE_LOW>;
>
>                 port {
> -                       #address-cells = <1>;
> -                       #size-cells = <0>;
> -
>                         ov5640_to_mipi_csi2: endpoint {

These two changes seem unrelated and I have already fixed them at:
https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git/commit/?h=imx/dt&id=1b215c73d1586e6f2586e9a6d6dfaf49cc142b3a

BTW, linux-next from today shows no W=1 DTC warnings on
imx_v6_v7_defconfig, but maybe new ones are coming soon :-)
