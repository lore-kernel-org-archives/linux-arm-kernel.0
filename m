From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 5 Jan 2017 18:50:10 +0100
Subject: [PATCH 3/5] arm64: dts: sun50i: add MMC nodes
In-Reply-To: <1483398226-29321-4-git-send-email-andre.przywara@arm.com>
References: <1483398226-29321-1-git-send-email-andre.przywara@arm.com>
 <1483398226-29321-4-git-send-email-andre.przywara@arm.com>
Message-ID: <20170105175010.j3qpqqkj3kmgrmyc@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 02, 2017 at 11:03:44PM +0000, Andre Przywara wrote:
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 67 +++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index e0dcab8..c680566 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -150,6 +150,32 @@
>  				pins = "PB8", "PB9";
>  				function = "uart0";
>  			};
> +
> +			mmc0_pins: mmc0 at 0 {
> +				pins = "PF0", "PF1", "PF2", "PF3", "PF4", "PF5";
> +				function = "mmc0";
> +				drive-strength = <30>;
> +			};
> +
> +			mmc0_default_cd_pin: mmc0_cd_pin at 0 {
> +				pins = "PF6";
> +				function = "gpio_in";
> +				bias-pull-up;
> +			};
> +
> +			mmc1_pins: mmc1 at 0 {
> +				pins = "PG0", "PG1", "PG2", "PG3", "PG4", "PG5";
> +				function = "mmc1";
> +				drive-strength = <30>;
> +			};
> +
> +			mmc2_pins: mmc2 at 0 {
> +				pins = "PC1", "PC5", "PC6", "PC8", "PC9",
> +				       "PC10", "PC11", "PC12", "PC13", "PC14",
> +				       "PC15", "PC16";
> +				function = "mmc2";
> +				drive-strength = <30>;
> +			};
>  		};
>  
>  		uart0: serial at 1c28000 {
> @@ -240,6 +266,47 @@
>  			#size-cells = <0>;
>  		};
>  
> +		mmc0: mmc at 1c0f000 {
> +			compatible = "allwinner,sun50i-a64-mmc",
> +				     "allwinner,sun5i-a13-mmc";

That's not correct. There's a bunch of features that are broken
without A64-specific (or at least not present on the A13)
quirks. Those features include for example the SDIO aggregation that
are currently broken for all modes supported so far.

I was in holidays and send those patches tomorrow, but you were a bit
too quick :)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170105/d1f8b2ae/attachment-0001.sig>
