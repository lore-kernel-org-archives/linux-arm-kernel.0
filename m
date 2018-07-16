From: andrew@aj.id.au (Andrew Jeffery)
Date: Mon, 16 Jul 2018 15:04:13 +0930
Subject: [PATCH 3/7] arm: dts: aspeed: Add Aspeed G4 USB Virtual Hub
In-Reply-To: <20180629035106.27181-4-benh@kernel.crashing.org>
References: <20180629035106.27181-1-benh@kernel.crashing.org>
 <20180629035106.27181-4-benh@kernel.crashing.org>
Message-ID: <1531719253.1117720.1441834824.43621FCB@webmail.messagingengine.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 29 Jun 2018, at 13:21, Benjamin Herrenschmidt wrote:
> This adds the (disabled by default) device node for the
> Aspeed virtual hub,a long with clocks and pinmux.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  arch/arm/boot/dts/aspeed-g4.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
> index 1d7ffa9fdb11..54524564037c 100644
> --- a/arch/arm/boot/dts/aspeed-g4.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g4.dtsi
> @@ -131,6 +131,16 @@
>  			 */
>  		};
>  
> +		vhub: usb-vhub at 1e6a0000 {
> +			compatible = "aspeed,ast2400-usb-vhub";
> +			reg = <0x1e6a0000 0x300>;
> +			interrupts = <5>;
> +			clocks = <&syscon ASPEED_CLK_GATE_USBPORT1CLK>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_usb2d_default>;
> +			status = "disabled";
> +		};
> +

These are all generic properties, so it's pretty clear what's going on, but it seems there's no bindings document capturing the compatible string? Not wanting to be a pain, but shouldn't we have documented it?

>  		apb {
>  			compatible = "simple-bus";
>  			#address-cells = <1>;
> -- 
> 2.17.1
> 
