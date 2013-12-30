From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 30 Dec 2013 16:16:26 +0100
Subject: [PATCH v2 4/4] ARM: dts: sun7i: Add pin muxing options for clock
 outputs
In-Reply-To: <1388373949-28506-5-git-send-email-wens@csie.org>
References: <1388373949-28506-1-git-send-email-wens@csie.org>
 <1388373949-28506-5-git-send-email-wens@csie.org>
Message-ID: <20131230151626.GT3144@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chen-Yu,

On Mon, Dec 30, 2013 at 11:25:49AM +0800, Chen-Yu Tsai wrote:
> This patch adds the clock output pin options on the A20.
> The 2 pins can output a configurable clock to be used by
> external modules. This is used on the CubieTruck, to supply
> a 32768 Hz low power clock to the onboard Wifi+BT module.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/boot/dts/sun7i-a20.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> index f255a49..7b46ce5 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -416,6 +416,20 @@
>  				allwinner,drive = <0>;
>  				allwinner,pull = <0>;
>  			};
> +
> +			clk_out_a_pins: clk_out_a at 0 {
> +				allwinner,pins = "PI12";
> +				allwinner,function = "clk_out_a";
> +				allwinner,drive = <0>;
> +				allwinner,pull = <0>;
> +			};
> +
> +			clk_out_b_pins: clk_out_b at 0 {
> +				allwinner,pins = "PI13";
> +				allwinner,function = "clk_out_b";
> +				allwinner,drive = <0>;
> +				allwinner,pull = <0>;
> +			};

The labels should be clk_out_[ab]_pins_a. That way, if another muxing
pops up for this clock, we will just need to add the new node, without
modifying the one you add just there.

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
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131230/19b5534f/attachment.sig>
