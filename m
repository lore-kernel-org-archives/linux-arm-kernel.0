From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 30 Jul 2015 15:44:59 +0800
Subject: [PATCH 6/7] ARM: sun9i: Add clock indices
In-Reply-To: <1437945270-32014-7-git-send-email-maxime.ripard@free-electrons.com>
References: <1437945270-32014-1-git-send-email-maxime.ripard@free-electrons.com>
 <1437945270-32014-7-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v65o8wh50u4pWuArspq+Bi=33JGp0TDF_N+hWZqHcRn4qQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 27, 2015 at 5:14 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The A80 gates have a non continuous set of clock IDs that are valid. Add
> the clock-indices property to the DT to express this.

The commit message does not match the patch, which is just a reformatting of
existing clock-indices properties.

> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/boot/dts/sun9i-a80.dtsi | 32 ++++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
> index a43ad779ee2f..5908e3dcf965 100644
> --- a/arch/arm/boot/dts/sun9i-a80.dtsi
> +++ b/arch/arm/boot/dts/sun9i-a80.dtsi
> @@ -277,9 +277,12 @@
>                         compatible = "allwinner,sun9i-a80-ahb0-gates-clk";
>                         reg = <0x06000580 0x4>;
>                         clocks = <&ahb0>;
> -                       clock-indices = <0>, <1>, <3>, <5>, <8>, <12>, <13>,
> -                                       <14>, <15>, <16>, <18>, <20>, <21>,
> -                                       <22>, <23>;
> +                       clock-indices = <0>, <1>, <3>,
> +                                       <5>, <8>, <12>,
> +                                       <13>, <14>,
> +                                       <15>, <16>, <18>,
> +                                       <20>, <21>, <22>,
> +                                       <23>;
>                         clock-output-names = "ahb0_fd", "ahb0_ve", "ahb0_gpu",
>                                         "ahb0_ss", "ahb0_sd", "ahb0_nand1",
>                                         "ahb0_nand0", "ahb0_sdram",
> @@ -293,7 +296,10 @@
>                         compatible = "allwinner,sun9i-a80-ahb1-gates-clk";
>                         reg = <0x06000584 0x4>;
>                         clocks = <&ahb1>;
> -                       clock-indices = <0>, <1>, <17>, <21>, <22>, <23>, <24>;
> +                       clock-indices = <0>, <1>,
> +                                       <17>, <21>,
> +                                       <22>, <23>,
> +                                       <24>;
>                         clock-output-names = "ahb1_usbotg", "ahb1_usbhci",
>                                         "ahb1_gmac", "ahb1_msgbox",
>                                         "ahb1_spinlock", "ahb1_hstimer",
> @@ -305,8 +311,9 @@
>                         compatible = "allwinner,sun9i-a80-ahb2-gates-clk";
>                         reg = <0x06000588 0x4>;
>                         clocks = <&ahb2>;
> -                       clock-indices = <0>, <1>, <2>, <4>, <5>, <7>, <8>,
> -                                       <11>;
> +                       clock-indices = <0>, <1>,
> +                                       <2>, <4>, <5>,
> +                                       <7>, <8>, <11>;
>                         clock-output-names = "ahb2_lcd0", "ahb2_lcd1",
>                                         "ahb2_edp", "ahb2_csi", "ahb2_hdmi",
>                                         "ahb2_de", "ahb2_mp", "ahb2_mipi_dsi";
> @@ -317,8 +324,10 @@
>                         compatible = "allwinner,sun9i-a80-apb0-gates-clk";
>                         reg = <0x06000590 0x4>;
>                         clocks = <&apb0>;
> -                       clock-indices = <1>, <5>, <11>, <12>, <13>, <15>,
> -                                       <17>, <18>, <19>;
> +                       clock-indices = <1>, <5>,
> +                                       <11>, <12>, <13>,
> +                                       <15>, <17>, <18>,
> +                                       <19>;
>                         clock-output-names = "apb0_spdif", "apb0_pio",
>                                         "apb0_ac97", "apb0_i2s0", "apb0_i2s1",
>                                         "apb0_lradc", "apb0_gpadc", "apb0_twd",
> @@ -330,8 +339,11 @@
>                         compatible = "allwinner,sun9i-a80-apb1-gates-clk";
>                         reg = <0x06000594 0x4>;
>                         clocks = <&apb1>;
> -                       clock-indices = <0>, <1>, <2>, <3>, <4>,
> -                                       <16>, <17>, <18>, <19>, <20>, <21>;
> +                       clock-indices = <0>, <1>,
> +                                       <2>, <3>, <4>,
> +                                       <16>, <17>,
> +                                       <18>, <19>,
> +                                       <20>, <21>;
>                         clock-output-names = "apb1_i2c0", "apb1_i2c1",
>                                         "apb1_i2c2", "apb1_i2c3", "apb1_i2c4",
>                                         "apb1_uart0", "apb1_uart1",
> --
> 2.4.6
>
