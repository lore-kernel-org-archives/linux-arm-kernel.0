From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 27 Mar 2017 08:46:25 +0200
Subject: [PATCH v2 2/2] ARM: dts: sun7i: Add CAN node and can0_pins_a
 pinctrl settings
In-Reply-To: <1490392339-23565-3-git-send-email-menschel.p@posteo.de>
References: <1490392339-23565-1-git-send-email-menschel.p@posteo.de>
 <1490392339-23565-3-git-send-email-menschel.p@posteo.de>
Message-ID: <20170327064625.we7ydn2oapwizncb@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Patrick,

On Fri, Mar 24, 2017 at 10:52:19PM +0100, Patrick Menschel wrote:
> The A20 SoC has an on-board CAN controller. This patch adds the device node
> and the corresponding pinctrl settings for pins PH20 and PH21.
> 
> The CAN controller is inherited from the A10 SoC and uses the same driver.
> 
> This patch is adapted from the description in
> Documentation/devicetree/bindings/net/can/sun4i_can.txt
> 
> Signed-off-by: Patrick Menschel <menschel.p@posteo.de>
> ---
>  arch/arm/boot/dts/sun7i-a20.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> index 2db97fc..25af586 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -1096,6 +1096,11 @@
>  			#interrupt-cells = <3>;
>  			#gpio-cells = <3>;
>  
> +			can0_pins_a: can0 at 0 {
> +				pins = "PH20","PH21";
> +				function = "can";
> +			};
> +
>  			clk_out_a_pins_a: clk_out_a at 0 {
>  				pins = "PI12";
>  				function = "clk_out_a";
> @@ -1582,6 +1587,14 @@
>  			#size-cells = <0>;
>  		};
>  
> +		can0: can at 01c2bc00 {
> +			compatible = "allwinner,sun4i-a10-can";

Sorry for not spotting this earlier, but this would need an A20
compatible too, to deal with the case where it turns out not to be
compatible.

you can do something like this:
compatible = "allwinner,sun7i-a20-can", "allwinner,sun4i-a10-can";

Ideally the pinctrl groups addition should be split out in a separate
patch too.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170327/b830b6cd/attachment.sig>
