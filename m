From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 10 Jul 2018 22:53:44 +0800
Subject: [linux-sunxi] [PATCH v5 09/22] ARM: dts: sun5i: Use
 most-qualified system control compatibles
In-Reply-To: <20180710080114.31469-10-paul.kocialkowski@bootlin.com>
References: <20180710080114.31469-1-paul.kocialkowski@bootlin.com>
 <20180710080114.31469-10-paul.kocialkowski@bootlin.com>
Message-ID: <CAGb2v64HbpvJhy5KQOepc61nU7NECaWMPvhZ16dk5hJXiPBHxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2018 at 4:01 PM, Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
> This switches the sun5i dtsi to use the most qualified compatibles for
> the system-control block (previously named SRAM controller) as well as
> the SRAM blocks. The sun4i-a10 compatibles are kept since these hardware
> blocks are backward-compatible.

Not quite sure why they are backward-compatible. The A13 has less SRAM
mapping controls than the A10.

ChenYu

> The phandle for system control is also updated to reflect the fact that
> the controller described is really about system control rather than SRAM
> control.
>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  arch/arm/boot/dts/sun5i.dtsi | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
> index 07f2248ed5f8..68711954c293 100644
> --- a/arch/arm/boot/dts/sun5i.dtsi
> +++ b/arch/arm/boot/dts/sun5i.dtsi
> @@ -114,8 +114,9 @@
>                 #size-cells = <1>;
>                 ranges;
>
> -               sram-controller at 1c00000 {
> -                       compatible = "allwinner,sun4i-a10-sram-controller";
> +               system-control at 1c00000 {
> +                       compatible = "allwinner,sun5i-a13-system-control",
> +                                    "allwinner,sun4i-a10-system-control";
>                         reg = <0x01c00000 0x30>;
>                         #address-cells = <1>;
>                         #size-cells = <1>;
> @@ -130,7 +131,8 @@
>                         };
>
>                         emac_sram: sram-section at 8000 {
> -                               compatible = "allwinner,sun4i-a10-sram-a3-a4";
> +                               compatible = "allwinner,sun5i-a13-sram-a3-a4",
> +                                            "allwinner,sun4i-a10-sram-a3-a4";
>                                 reg = <0x8000 0x4000>;
>                                 status = "disabled";
>                         };
> @@ -143,7 +145,8 @@
>                                 ranges = <0 0x00010000 0x1000>;
>
>                                 otg_sram: sram-section at 0 {
> -                                       compatible = "allwinner,sun4i-a10-sram-d";
> +                                       compatible = "allwinner,sun5i-a13-sram-d",
> +                                                    "allwinner,sun4i-a10-sram-d";
>                                         reg = <0x0000 0x1000>;
>                                         status = "disabled";
>                                 };
> --
> 2.17.1
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
