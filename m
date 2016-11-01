From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 1 Nov 2016 12:48:06 +0300
Subject: [RFC PATCH v2 3/5] ARM64: dts: meson-gxl: Add ethernet nodes with
 internal PHY
In-Reply-To: <1477932987-27871-4-git-send-email-narmstrong@baylibre.com>
References: <1477932987-27871-1-git-send-email-narmstrong@baylibre.com>
 <1477932987-27871-4-git-send-email-narmstrong@baylibre.com>
Message-ID: <52cb99f1-93ef-ea53-63c1-a661c2790538@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 10/31/2016 7:56 PM, Neil Armstrong wrote:

> Add Ethernet node with Internal PHY selection for the Amlogic GXL SoCs
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxl.dtsi | 45 ++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
> index d1bf381..71670c3 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
> @@ -47,6 +47,24 @@
>
>  / {
>  	compatible = "amlogic,meson-gxl";
> +
> +

    No need for these empty lines.

> +};
> +
> +&ethmac {
> +	reg = <0x0 0xc9410000 0x0 0x10000
> +	       0x0 0xc8834540 0x0 0x4>;
> +
> +	clocks = <&clkc CLKID_ETH>,
> +		 <&clkc CLKID_FCLK_DIV2>,
> +		 <&clkc CLKID_MPLL2>;
> +	clock-names = "stmmaceth", "clkin0", "clkin1";
> +
> +	mdio0: mdio0 {

    Should be "mdio0: mdio {" in oprder to comply woth the DT spec.

> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "snps,dwmac-mdio";
> +	};
>  };
>
>  &aobus {
[...]

MBR, Sergei
