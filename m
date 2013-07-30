From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 30 Jul 2013 23:07:21 +0400
Subject: [PATCH 08/10] ARM: sun7i: DT: Add UART muxing options to the DTSI
In-Reply-To: <1375196394-21138-9-git-send-email-maxime.ripard@free-electrons.com>
References: <1375196394-21138-1-git-send-email-maxime.ripard@free-electrons.com>
 <1375196394-21138-9-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <51F80EE9.30801@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 07/30/2013 06:59 PM, Maxime Ripard wrote:

> The UARTs on the A20 can be muxed to several pins. Add a few options to
> the DTSI so that we can start using them in the boards' DT.

> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>   arch/arm/boot/dts/sun7i-a20.dtsi | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)

> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> index 704fca9..9f45e8d 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -70,6 +70,27 @@
>   			#address-cells = <1>;
>   			#size-cells = <0>;
>   			#gpio-cells = <3>;
> +
> +			uart0_pins_a: uart0 at 0 {

    Why have address part of the node name if there's not "reg" property?
And the preferred node name is "serial", not "uart", according to the ePAPR 
spec (http://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.0.pdf).

> +				allwinner,pins = "PB22", "PB23";
> +				allwinner,function = "uart0";
> +				allwinner,drive = <0>;
> +				allwinner,pull = <0>;
> +			};
> +
> +			uart6_pins_a: uart6 at 0 {
> +				allwinner,pins = "PI12", "PI13";
> +				allwinner,function = "uart6";
> +				allwinner,drive = <0>;
> +				allwinner,pull = <0>;
> +			};
> +
> +			uart7_pins_a: uart7 at 0 {
> +				allwinner,pins = "PI20", "PI21";
> +				allwinner,function = "uart7";
> +				allwinner,drive = <0>;
> +				allwinner,pull = <0>;
> +			};

WBR, Sergei
