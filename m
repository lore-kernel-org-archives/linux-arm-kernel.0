From: b.brezillon@overkiz.com (boris brezillon)
Date: Wed, 08 Jan 2014 16:30:04 +0100
Subject: [RFC PATCH 9/9] ARM: sunxi/dt: enable NAND on cubietruck board
In-Reply-To: <1389194891-26771-1-git-send-email-b.brezillon@overkiz.com>
References: <1389190924-26226-1-git-send-email-b.brezillon@overkiz.com>
 <1389194891-26771-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <52CD6EFC.9050303@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/01/2014 16:28, Boris BREZILLON wrote:
> Enable the NFC and describe the NAND flash connected to this controller.
>
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
> ---
>   arch/arm/boot/dts/sun7i-a20-cubietruck.dts |   33 ++++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> index 8a1009d..08ee7d3 100644
> --- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> @@ -18,7 +18,40 @@
>   	model = "Cubietech Cubietruck";
>   	compatible = "cubietech,cubietruck", "allwinner,sun7i-a20";
>   
> +	chosen {
> +		bootargs = "console=ttyS0,115200 earlyprintk root=/dev/ram0 rootfstype=ext2 rw";
> +	};
> +

Sorry, I messed up with the bootargs.
I'll remove it in the next version.

>   	soc at 01c00000 {
> +		nfc: nand at 01c03000 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&nand_pins_a &nand_cs0_pins_a &nand_rb0_pins_a>;
> +			status = "okay";
> +
> +			nand at 0 {
> +				reg = <0>;
> +				allwinner,rb = <0>;
> +				nand-ecc-mode = "soft_bch";
> +
> +				/* nand timings */
> +				tCLS-min = <6>;
> +				tCLH-min = <3>;
> +				tCS-min = <20>;
> +				tCH-min = <5>;
> +				tWP-min = <8>;
> +				tWH-min = <6>;
> +				tALS-min = <6>;
> +				tDS-min = <6>;
> +				tDH-min = <2>;
> +				tRR-min = <20>;
> +				tALH-min = <3>;
> +				tRP-min = <8>;
> +				tREH-min = <6>;
> +				tRC-min = <16>;
> +				tWC-min = <16>;
> +			};
> +		};
> +
>   		pinctrl at 01c20800 {
>   			led_pins_cubietruck: led_pins at 0 {
>   				allwinner,pins = "PH7", "PH11", "PH20", "PH21";
