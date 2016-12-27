From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 27 Dec 2016 10:11:34 +0800
Subject: [PATCH v2] ARM: dts: sunxi: Add num-cs for A20 spi nodes
In-Reply-To: <20161226174748.17544-1-manu@bidouilliste.com>
References: <20161226174748.17544-1-manu@bidouilliste.com>
Message-ID: <CAGb2v665UkdGvV-PO_eKRdY78XzVeHSpmev2h+2umbEYUbZ3GQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Dec 27, 2016 at 1:47 AM, Emmanuel Vadot <manu@bidouilliste.com> wrote:
> The spi0 controller on the A20 have up to 4 CS (Chip Select) while the
> others three only have 1.
> Add the num-cs property to each node.
> The current driver doesn't read this property but this is useful for
> downstream user of DTS (FreeBSD for example).
>
> Signed-off-by: Emmanuel Vadot <manu@bidouilliste.com>
> ---
>
> Changes in v2:
>  * Explain that driver doesn't support this but that it is useful
>  for downstream users of DTS.
>
>  arch/arm/boot/dts/sun7i-a20.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> index 94cf5a1c7172..ed21982c81cb 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -871,6 +871,7 @@
>                         status = "disabled";
>                         #address-cells = <1>;
>                         #size-cells = <0>;
> +                       num-cs = 4;

The numbers need to be enclosed in angle brackets.

ChenYu

>                 };
>
>                 spi1: spi at 01c06000 {
> @@ -885,6 +886,7 @@
>                         status = "disabled";
>                         #address-cells = <1>;
>                         #size-cells = <0>;
> +                       num-cs = 1;
>                 };
>
>                 emac: ethernet at 01c0b000 {
> @@ -1037,6 +1039,7 @@
>                         status = "disabled";
>                         #address-cells = <1>;
>                         #size-cells = <0>;
> +                       num-cs = 1;
>                 };
>
>                 ahci: sata at 01c18000 {
> @@ -1079,6 +1082,7 @@
>                         status = "disabled";
>                         #address-cells = <1>;
>                         #size-cells = <0>;
> +                       num-cs = 1;
>                 };
>
>                 pio: pinctrl at 01c20800 {
> --
> 2.11.0
>
