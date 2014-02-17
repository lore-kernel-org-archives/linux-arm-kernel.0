From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 17 Feb 2014 21:06:23 +0900
Subject: [PATCH V2 1/2] ARM: shmobile: r8a7791: add i2c master nodes to
 dtsi
In-Reply-To: <1392633882-12142-1-git-send-email-wsa@the-dreams.de>
References: <1392633882-12142-1-git-send-email-wsa@the-dreams.de>
Message-ID: <CANqRtoQvvTQ5r1X7KiGwPoft-GZK8qp-X1z31Hi8FO0bcQ3yZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 17, 2014 at 7:44 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> From: Wolfram Sang <wsa@sang-engineering.com>
>
> Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
> ---
>  arch/arm/boot/dts/r8a7791.dtsi | 69 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
>
> diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
> index 41194fe..1ab4f3d 100644
> --- a/arch/arm/boot/dts/r8a7791.dtsi
> +++ b/arch/arm/boot/dts/r8a7791.dtsi
> @@ -19,6 +19,15 @@
>         #address-cells = <2>;
>         #size-cells = <2>;
>
> +       aliases {
> +               i2c0 = &i2c0;
> +               i2c1 = &i2c1;
> +               i2c2 = &i2c2;
> +               i2c3 = &i2c3;
> +               i2c4 = &i2c4;
> +               i2c5 = &i2c5;
> +       };
> +
>         cpus {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
> @@ -170,6 +179,66 @@
>                              <0 17 IRQ_TYPE_LEVEL_HIGH>;
>         };
>
> +       i2c0: i2c at e6508000 {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               compatible = "renesas,i2c-r8a7791";

V2 of this patch looks good to me, thanks!

Acked-by: Magnus Damm <damm@opensource.se>

When you have time, please send an incremental patch to add support
for the three IIC channels as well.

Cheers,

/ magnus
