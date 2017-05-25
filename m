From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 25 May 2017 10:57:39 +0800
Subject: [PATCH v2 1/2] ARM: dts: orange-pi-zero: specify wifi interrupts
In-Reply-To: <20170524212433.14386-2-geomatsi@gmail.com>
References: <20170524212433.14386-1-geomatsi@gmail.com>
 <20170524212433.14386-2-geomatsi@gmail.com>
Message-ID: <CAGb2v647GTQW9-ZYrkWS7RoeYTu_7oTm8v4PDs0YD1pZ8oUohQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 25, 2017 at 5:24 AM, Sergey Matyukevich <geomatsi@gmail.com> wrote:
> The orange-pi-zero board has Allwinner XR819 SDIO wifi chip. The board
> dts file provides a node enabling mmc1 controller. Together with an
> out-of-tree driver https://github.com/fifteenhex/xradio this node
> enables using the wifi chip.
>
> This commit specifies XR819 interrupt configuration for the driver.
>
> Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
> index 9e8b082c134f..e97dfd1775d1 100644
> --- a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
> +++ b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
> @@ -128,6 +128,9 @@
>          */
>         xr819: sdio_wifi at 1 {
>                 reg = <1>;
> +               compatible = "xradio,xr819";

You should submit device tree bindings first. See:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/net/wireless

for examples.

> +               interrupt-parent = <&pio>;
> +               interrupts = <6 10 IRQ_TYPE_EDGE_RISING>;

Are these optional or required properties? AFAIK SDIO supports in-band
interrupts with a bit of overhead, so they should be optional.

ChenYu

>         };
>  };
>
> --
> 2.11.0
>
