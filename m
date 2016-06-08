From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 9 Jun 2016 00:04:54 +0200
Subject: [PATCH 1/7] ARM: dts: sun4i: Add A10 NAND controller pin
 definitions
In-Reply-To: <1465208664-9366-2-git-send-email-mamlinav@gmail.com>
References: <1465208664-9366-1-git-send-email-mamlinav@gmail.com>
 <1465208664-9366-2-git-send-email-mamlinav@gmail.com>
Message-ID: <20160608220454.GM14179@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jun 06, 2016 at 01:24:18PM +0300, Aleksei Mamlin wrote:
> From: Boris Brezillon <boris.brezillon@free-electrons.com>
> 
> Define the NAND controller pin configs.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Signed-off-by: Aleksei Mamlin <mamlinav@gmail.com>
> ---
>  arch/arm/boot/dts/sun4i-a10.dtsi | 80 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
> index a9c3190..146a08db 100644
> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> @@ -1144,6 +1144,86 @@
>  				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>  				allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
>  			};
> +
> +			nand_pins_a: nand_base0 at 0 {
> +				allwinner,pins = "PC0", "PC1", "PC2",
> +						"PC5", "PC8", "PC9", "PC10",
> +						"PC11", "PC12", "PC13", "PC14",
> +						"PC15", "PC16";
> +				allwinner,function = "nand0";
> +				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +			};
> +
> +			nand_cs0_pins_a: nand_cs at 0 {
> +				allwinner,pins = "PC4";
> +				allwinner,function = "nand0";
> +				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +			};
> +
> +			nand_cs1_pins_a: nand_cs at 1 {
> +				allwinner,pins = "PC3";
> +				allwinner,function = "nand0";
> +				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +			};
> +
> +			nand_cs2_pins_a: nand_cs at 2 {
> +				allwinner,pins = "PC17";
> +				allwinner,function = "nand0";
> +				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +			};
> +
> +			nand_cs3_pins_a: nand_cs at 3 {
> +				allwinner,pins = "PC18";
> +				allwinner,function = "nand0";
> +				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +			};
> +
> +			nand_cs4_pins_a: nand_cs at 4 {
> +				allwinner,pins = "PC19";
> +				allwinner,function = "nand0";
> +				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +			};
> +
> +			nand_cs5_pins_a: nand_cs at 5 {
> +				allwinner,pins = "PC20";
> +				allwinner,function = "nand0";
> +				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +			};
> +
> +			nand_cs6_pins_a: nand_cs at 6 {
> +				allwinner,pins = "PC21";
> +				allwinner,function = "nand0";
> +				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +			};
> +
> +			nand_cs7_pins_a: nand_cs at 7 {
> +				allwinner,pins = "PC22";
> +				allwinner,function = "nand0";
> +				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +			};
> +
> +			nand_rb0_pins_a: nand_rb at 0 {
> +				allwinner,pins = "PC6";
> +				allwinner,function = "nand0";
> +				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +			};
> +
> +			nand_rb1_pins_a: nand_rb at 1 {
> +				allwinner,pins = "PC7";
> +				allwinner,function = "nand0";
> +				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +			};

We usually enable only the pin groups that are actually used by some
board to avoid bloating the DT too much.

And the nodes should be sorted alphabetically.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160609/0da21566/attachment-0001.sig>
