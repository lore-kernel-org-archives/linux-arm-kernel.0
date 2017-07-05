From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Wed, 5 Jul 2017 17:23:43 +0200
Subject: [PATCH v2 4/5] ARM: dts: at91: at91-sama5d27_som1: add sama5d27
 SoM1 support
In-Reply-To: <1499086572-6083-5-git-send-email-claudiu.beznea@microchip.com>
References: <1499086572-6083-1-git-send-email-claudiu.beznea@microchip.com>
 <1499086572-6083-5-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <20170705152343.b735on6edg3vfsp3@rfolt0960.corp.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 03, 2017 at 03:56:11PM +0300, Claudiu Beznea wrote:
> Add specific DTS file and bindings for sama5d27 SoM1 board.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
> ---
>  arch/arm/boot/dts/at91-sama5d27_som1.dtsi | 178 ++++++++++++++++++++++++++++++
>  1 file changed, 178 insertions(+)
>  create mode 100644 arch/arm/boot/dts/at91-sama5d27_som1.dtsi
> 
> diff --git a/arch/arm/boot/dts/at91-sama5d27_som1.dtsi b/arch/arm/boot/dts/at91-sama5d27_som1.dtsi
> new file mode 100644
> index 0000000..c3a1dc8
> --- /dev/null
> +++ b/arch/arm/boot/dts/at91-sama5d27_som1.dtsi

[...]

> +
> +			i2c0: i2c at f8028000 {
> +				dmas = <0>, <0>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_i2c0_default>;
> +				i2c-sda-hold-time-ns = <350>;
> +				status = "disabled";
> +
> +				24aa at 50 {
> +					compatible = "24mac602";
> +					reg = <0x50>;
> +					pagesize = <8>;
> +					start-offset = /bits/ 8 <0xf8>;

Are you sure about the offset? I thought it was 0xfa but maybe I am
wrong.

Regards

Ludovic
