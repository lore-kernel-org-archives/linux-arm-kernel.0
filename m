From: andrew@aj.id.au (Andrew Jeffery)
Date: Mon, 16 Jul 2018 15:06:29 +0930
Subject: [PATCH 4/7] arm: dts: aspeed: Add Aspeed 54 USB Virtual Hub
In-Reply-To: <20180629035106.27181-5-benh@kernel.crashing.org>
References: <20180629035106.27181-1-benh@kernel.crashing.org>
 <20180629035106.27181-5-benh@kernel.crashing.org>
Message-ID: <1531719389.1118131.1441835376.01278A09@webmail.messagingengine.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Typo: '54' in the subject should be 'G5'

On Fri, 29 Jun 2018, at 13:21, Benjamin Herrenschmidt wrote:
> This adds the (disabled by default) device node for the
> Aspeed virtual hub,a long with clocks and pinmux.
> 
> This also adds the missing pinmux definition for it
> (the kernel driver already knows about it).

Whoops! Thanks for catching that.

> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  arch/arm/boot/dts/aspeed-g5.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
> index dfdc239b86f6..6274d3eaf374 100644
> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> @@ -176,6 +176,16 @@
>  			 */
>  		};
>  
> +		vhub: usb-vhub at 1e6a0000 {
> +			compatible = "aspeed,ast2500-usb-vhub";
> +			reg = <0x1e6a0000 0x300>;
> +			interrupts = <5>;
> +			clocks = <&syscon ASPEED_CLK_GATE_USBPORT1CLK>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_usb2ad_default>;
> +			status = "disabled";
> +		};
> +

Same query about the compatible before.

>  		apb {
>  			compatible = "simple-bus";
>  			#address-cells = <1>;
> @@ -1425,6 +1435,11 @@
>  		groups = "USB2AH";
>  	};
>  
> +	pinctrl_usb2ad_default: usb2ad_default {
> +		function = "USB2AD";
> +		groups = "USB2AD";
> +	};
> +
>  	pinctrl_usb11bhid_default: usb11bhid_default {
>  		function = "USB11BHID";
>  		groups = "USB11BHID";
> -- 
> 2.17.1
> 
