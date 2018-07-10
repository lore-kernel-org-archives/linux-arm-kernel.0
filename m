From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 10 Jul 2018 22:52:39 +0800
Subject: [PATCH v5 08/22] ARM: dts: sun4i-a10: Use system-control
 compatible
In-Reply-To: <20180710080114.31469-9-paul.kocialkowski@bootlin.com>
References: <20180710080114.31469-1-paul.kocialkowski@bootlin.com>
 <20180710080114.31469-9-paul.kocialkowski@bootlin.com>
Message-ID: <CAGb2v65JP8fBvD6Sbexjg2cv5AXVufWxjMVuOPa7J1A9qQjZ2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2018 at 4:01 PM, Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:

Subject prefix should be "ARM: dts: sun4i:"

We don't need the "a10" part since the A10 owns into this category
all by itself.

Also, it doesn't say what the system control compatible is for.
"Switch to new system control compatible string" would be slightly
better.

> This switches the sun4i-a10 dtsi to use the new compatible for the
> system-control block (previously named SRAM controller) instead of
> the deprecated one.
>
> The phandle is also updated to reflect the fact that the controller

The label actually.

ChenYu

> described is really about system control rather than SRAM control.
>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  arch/arm/boot/dts/sun4i-a10.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
> index 3a1c6b45c9a1..82f81f06f201 100644
> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> @@ -190,8 +190,8 @@
>                 #size-cells = <1>;
>                 ranges;
>
> -               sram-controller at 1c00000 {
> -                       compatible = "allwinner,sun4i-a10-sram-controller";
> +               system-control at 1c00000 {
> +                       compatible = "allwinner,sun4i-a10-system-control";
>                         reg = <0x01c00000 0x30>;
>                         #address-cells = <1>;
>                         #size-cells = <1>;
> --
> 2.17.1
>
