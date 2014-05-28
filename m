From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 May 2014 23:14:29 +0800
Subject: [linux-sunxi] [PATCH v9 1/2] Documentation: dt: Add Allwinner A31
 DMA controller bindings
In-Reply-To: <1400762084-31606-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1400762084-31606-1-git-send-email-maxime.ripard@free-electrons.com>
 <1400762084-31606-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v67ekvfjx+nFNGfVkWYH1XeeHq4+jPGsVZBzCQNPH9Eddg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 22, 2014 at 8:34 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The Allwinner A31 DMA controller is rather simple to describe in the DT. Add
> the bindings documentation.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  .../devicetree/bindings/dma/sun6i-dma.txt          | 45 ++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/sun6i-dma.txt
>
> diff --git a/Documentation/devicetree/bindings/dma/sun6i-dma.txt b/Documentation/devicetree/bindings/dma/sun6i-dma.txt
> new file mode 100644
> index 000000000000..5d7c86d52665
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/sun6i-dma.txt
> @@ -0,0 +1,45 @@
> +Allwinner A31 DMA Controller
> +
> +This driver follows the generic DMA bindings defined in dma.txt.
> +
> +Required properties:
> +
> +- compatible:  Must be "allwinner,sun6i-a31-dma"
> +- reg:         Should contain the registers base address and length
> +- interrupts:  Should contain a reference to the interrupt used by this device
> +- clocks:      Should contain a reference to the parent AHB clock
> +- resets:      Should contain a reference to the reset controller asserting
> +               this device in reset

Extra spaces between the leading tabs.
(Gmail messes up whitespaces, please see original mail.)

> +- #dma-cells : Should be 1, a single cell holding a line request number
> +
> +Example:
> +       dma: dma-controller at 01c02000 {
> +               compatible = "allwinner,sun6i-a31-dma";
> +               reg = <0x01c02000 0x1000>;
> +               interrupts = <0 50 4>;
> +               clocks = <&ahb1_gates 6>;
> +               resets = <&ahb1_rst 6>;
> +               #dma-cells = <1>;
> +       };
> +
> +Clients:
> +
> +DMA clients connected to the A31 DMA controller must use the format
> +described in the dma.txt file, using a two-cell specifier for each
> +channel: a phandle plus one integer cells.
> +The two cells in order are:
> +
> +1. A phandle pointing to the DMA controller.
> +2. The port ID as specified in the datasheet
> +
> +Example:
> +spi2: spi at 01c6a000 {
> +       compatible = "allwinner,sun6i-a31-spi";
> +       reg = <0x01c6a000 0x1000>;
> +       interrupts = <0 67 4>;
> +       clocks = <&ahb1_gates 22>, <&spi2_clk>;
> +       clock-names = "ahb", "mod";
> +       dmas = <&dma 25>, <&dma 25>;
> +       dma-names = "rx", "tx";
> +       resets = <&ahb1_rst 22>;
> +};
> --
> 1.9.3
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
