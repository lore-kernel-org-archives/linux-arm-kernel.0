From: voice.shen@atmel.com (Bo Shen)
Date: Wed, 25 Jun 2014 14:59:40 +0800
Subject: [PATCH 1/2] ARM: at91/dt: describe rgmii ethernet phy connected
 to sama5d3xek boards
In-Reply-To: <1403649878-28242-2-git-send-email-boris.brezillon@free-electrons.com>
References: <1403649878-28242-1-git-send-email-boris.brezillon@free-electrons.com>
 <1403649878-28242-2-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <53AA735C.7050805@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On 06/25/2014 06:44 AM, Boris BREZILLON wrote:
> Add ethernet-phy node to specify phy address (on the MDIO bus) and phy
> interrupt (connected to pin PB25).
>
> Define board specific delays to apply to RGMII signals.
>
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> ---
>   arch/arm/boot/dts/sama5d3xcm.dtsi | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sama5d3xcm.dtsi b/arch/arm/boot/dts/sama5d3xcm.dtsi
> index b0b1331..2185ad8 100644
> --- a/arch/arm/boot/dts/sama5d3xcm.dtsi
> +++ b/arch/arm/boot/dts/sama5d3xcm.dtsi
> @@ -34,6 +34,22 @@
>
>   			macb0: ethernet at f0028000 {
>   				phy-mode = "rgmii";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				ethernet-phy at 1 {

The GMAC PHY address is 0x7 while not 0x1.

> +					interrupt-parent = <&pioB>;
> +					interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
> +					reg = <1>;

Nitpick: as usual, we will add "0x" prefix in reg property.

> +					txen-skew-ps = <800>;
> +					txc-skew-ps = <12000>;
> +					rxdv-skew-ps = <400>;
> +					rxc-skew-ps = <12000>;
> +					rxd0-skew-ps = <400>;
> +					rxd1-skew-ps = <400>;
> +					rxd2-skew-ps = <400>;
> +					rxd3-skew-ps = <400>;
> +				};
>   			};
>
>   			pmc: pmc at fffffc00 {
>

Best Regards,
Bo Shen
