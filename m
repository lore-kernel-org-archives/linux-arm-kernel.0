From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 28 Jul 2014 12:28:13 +0800
Subject: [RFC 8/8] ARM: sun7i: Add mod1 clock nodes
In-Reply-To: <1406519386-4902-9-git-send-email-emilio@elopez.com.ar>
References: <1406519386-4902-1-git-send-email-emilio@elopez.com.ar>
 <1406519386-4902-9-git-send-email-emilio@elopez.com.ar>
Message-ID: <CAGb2v64Gg4E5QJOZJjWezG2BNzD6iOnBvT6EYq=8AcTXGqrvsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

First I suggest adding "DT: " to the commit line of all the DT patches.

On Mon, Jul 28, 2014 at 11:49 AM, Emilio L?pez <emilio@elopez.com.ar> wrote:
> This commit adds all the mod1 clocks available on A20 to its device
> tree. This list was created by looking at the A20 user manual.
>
> Not-signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> ---
>
> As mentioned on an earlier patch, note that this is untested, and I
> only added them to sun7i. It'd be great if actual users of these clocks
> could comment :)
>
>  arch/arm/boot/dts/sun7i-a20.dtsi | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> index 5d0265a..c57f7ad 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -335,6 +335,29 @@
>                         clock-output-names = "ir1";
>                 };
>
> +               iis0_clk: clk at 01c200b8 {
> +                       #clock-cells = <0>;
> +                       compatible = "allwinner,sun4i-a10-mod1-clk";
> +                       reg = <0x01c200b8 0x4>;
> +                       clocks = <&pll2 0>, <&pll2 1>, <&pll2 2>, <&pll2 3>;

User manual says pll2x8, pll2x4, pll2x2, pll2 for all the the clocks.
So the order here should be reversed. Same for the others.

> +                       clock-output-names = "iis0";
> +               };
> +
> +               ac97_clk: clk at 01c200bc {
> +                       #clock-cells = <0>;
> +                       compatible = "allwinner,sun4i-a10-mod1-clk";
> +                       reg = <0x01c200bc 0x4>;
> +                       clocks = <&pll2 3>, <&pll2 2>, <&pll2 1>, <&pll2 0>;
> +                       clock-output-names = "ac97";
> +               };
> +
> +               spdif_clk: clk at 01c200c0 {
> +                       #clock-cells = <0>;
> +                       compatible = "allwinner,sun4i-a10-mod1-clk";
> +                       reg = <0x01c200c0 0x4>;
> +                       clocks = <&pll2 0>, <&pll2 1>, <&pll2 2>, <&pll2 3>;
> +                       clock-output-names = "spdif";
> +               };

Newline. And the manuals don't have anything on the SPDIF clock,
so I can't comment on it.

>                 usb_clk: clk at 01c200cc {
>                         #clock-cells = <1>;
>                         #reset-cells = <1>;
> @@ -352,6 +375,22 @@
>                         clock-output-names = "spi3";
>                 };
>
> +               iis1_clk: clk at 01c200d8 {
> +                       #clock-cells = <0>;
> +                       compatible = "allwinner,sun4i-a10-mod1-clk";
> +                       reg = <0x01c200d8 0x4>;
> +                       clocks = <&pll2 0>, <&pll2 1>, <&pll2 2>, <&pll2 3>;
> +                       clock-output-names = "iis1";
> +               };
> +
> +               iis2_clk: clk at 01c200dc {
> +                       #clock-cells = <0>;
> +                       compatible = "allwinner,sun4i-a10-mod1-clk";
> +                       reg = <0x01c200dc 0x4>;
> +                       clocks = <&pll2 0>, <&pll2 1>, <&pll2 2>, <&pll2 3>;
> +                       clock-output-names = "iis2";
> +               };
> +
>                 codec_clk: clk at 01c20140 {
>                         #clock-cells = <0>;
>                         compatible = "allwinner,sun4i-a10-codec-clk";
> --

Apart from the title and the clock orders, everything looks good.
Jon should test this with the above corrected.


Cheers
ChenYu
