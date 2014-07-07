From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 7 Jul 2014 15:35:51 +0800
Subject: [PATCH v2 3/8] ARM: sun4i: Add node to represent the DMA
 controller
In-Reply-To: <1404619518-7592-4-git-send-email-emilio@elopez.com.ar>
References: <1404619518-7592-1-git-send-email-emilio@elopez.com.ar>
 <1404619518-7592-4-git-send-email-emilio@elopez.com.ar>
Message-ID: <CAGb2v653fe7J1D=BrN5ngRwDf9myVAtaQZTZfTmec8XR9EBpwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 6, 2014 at 12:05 PM, Emilio L?pez <emilio@elopez.com.ar> wrote:
> Let's add a node to represent the A10 DMA controller on the device tree.
>
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> ---
>  arch/arm/boot/dts/sun4i-a10.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
> index d96e179..f17cbeb 100644
> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> @@ -339,6 +339,14 @@
>                 #size-cells = <1>;
>                 ranges;
>
> +               dma: dma-controller at 01c02000 {
> +                       compatible = "allwinner,sun4i-a10-dma";
> +                       reg = <0x01c02000 0x1000>;
> +                       interrupts = <27>;
> +                       clocks = <&ahb_gates 6>;
> +                       #dma-cells = <2>;

Whitespace errors, otherwise good.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>


> +               };
> +
>                 spi0: spi at 01c05000 {
>                         compatible = "allwinner,sun4i-a10-spi";
>                         reg = <0x01c05000 0x1000>;
> --
> 2.0.1
