From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 20 Mar 2017 08:49:26 +0100
Subject: [PATCH 1/2] ARM: dts: sun4i: Add CAN node and can0_pins_a
 pinctrl settings
In-Reply-To: <1489325291-6298-2-git-send-email-menschel.p@posteo.de>
References: <1489325291-6298-1-git-send-email-menschel.p@posteo.de>
 <1489325291-6298-2-git-send-email-menschel.p@posteo.de>
Message-ID: <20170320074926.fo6jgjv3qerkz2cu@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Patrick,

On Sun, Mar 12, 2017 at 02:28:10PM +0100, Patrick Menschel wrote:
> The A10 SoC has an on-board CAN controller. This patch adds the device node
> and the corresponding pinctrl settings for pins PH20 and PH21.
> 
> This patch is adapted from the description in
> Documentation/devicetree/bindings/net/can/sun4i_can.txt
> 
> Signed-off-by: Patrick Menschel <menschel.p@posteo.de>
> ---
>  arch/arm/boot/dts/sun4i-a10.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
> index b14a428..210b616 100644
> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> @@ -1160,6 +1160,13 @@
>  				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>  				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>  			};
> +
> +			can0_pins_a: can0 at 0 {

That should be ordered by alphabetical order.

> +				allwinner,pins = "PH20","PH21";
> +				allwinner,function = "can";
> +				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;

We've switched to a new, generic, binding recently for the pinctrl
nodes.

In your case, that would mean dropping "allwinner," from the pins and
functions properties, and droping the last two properties entirely.

> +			};
>  		};
>  
>  		timer at 01c20c00 {
> @@ -1376,5 +1383,13 @@
>  			clocks = <&apb1_gates 7>;
>  			status = "disabled";
>  		};
> +
> +		can0: can at 01c2bc00 {

And this one should be ordered by rising physical addresses.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170320/60f38744/attachment.sig>
