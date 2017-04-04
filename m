From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 4 Apr 2017 17:40:18 +0200
Subject: [PATCH v3 1/4] ARM: dts: sun4i: Add CAN node
In-Reply-To: <1491238814-4888-2-git-send-email-menschel.p@posteo.de>
References: <1491238814-4888-1-git-send-email-menschel.p@posteo.de>
 <1491238814-4888-2-git-send-email-menschel.p@posteo.de>
Message-ID: <20170404154018.6phu2udfgwuzklkk@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 03, 2017 at 07:00:11PM +0200, Patrick Menschel wrote:
> The A10 SoC has an on-board CAN controller.
> This patch adds the device node.
> 
> This patch is adapted from the description in
> Documentation/devicetree/bindings/net/can/sun4i_can.txt
> 
> Signed-off-by: Patrick Menschel <menschel.p@posteo.de>
> ---
>  arch/arm/boot/dts/sun4i-a10.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
> index ba20b48..7c559e7 100644
> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> @@ -1313,6 +1313,14 @@
>  			#size-cells = <0>;
>  		};
>  
> +		can0: can at 01c2bc00 {
> +			compatible = "allwinner,sun4i-a10-can";
> +			reg = <0x01c2bc00 0x400>;
> +			interrupts = <26>;
> +			clocks = <&apb1_gates 4>;
> +			status = "disabled";
> +		};
> +

This wasn't ordered properly. Fixed and applied.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170404/d8b959e7/attachment-0001.sig>
