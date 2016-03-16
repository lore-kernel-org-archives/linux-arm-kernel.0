From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Tue, 15 Mar 2016 18:34:26 -0700
Subject: [PATCH 5/7] dmaengine: xilinx_vdma: Remove unnecessary axi dma
 device-tree binding doc
In-Reply-To: <1458062592-27981-6-git-send-email-appanad@xilinx.com>
References: <1458062592-27981-1-git-send-email-appanad@xilinx.com>
 <1458062592-27981-6-git-send-email-appanad@xilinx.com>
Message-ID: <CAAtXAHeKd7NjWdPFczDTSN8yLJFPHTorvH+eNrcww7naCViytA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi there,

On Tue, Mar 15, 2016 at 10:23 AM, Kedareswara rao Appana
<appana.durga.rao@xilinx.com> wrote:
> AXI DMA support is added to the existing AXI VDMA driver.
> The binding doc for AXI DMA should also be updated in the
> VDMA device-tree binding doc.
>
> Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> ---
>  .../devicetree/bindings/dma/xilinx/xilinx_dma.txt  | 65 ----------------------
>  1 file changed, 65 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
>
> diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> deleted file mode 100644
> index 2291c40..0000000
> --- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> +++ /dev/null
> @@ -1,65 +0,0 @@
> -Xilinx AXI DMA engine, it does transfers between memory and AXI4 stream
> -target devices. It can be configured to have one channel or two channels.
> -If configured as two channels, one is to transmit to the device and another
> -is to receive from the device.
> -
> -Required properties:
> -- compatible: Should be "xlnx,axi-dma-1.00.a"
> -- #dma-cells: Should be <1>, see "dmas" property below
> -- reg: Should contain DMA registers location and length.
> -- dma-channel child node: Should have atleast one channel and can have upto
> -       two channels per device. This node specifies the properties of each
> -       DMA channel (see child node properties below).

at least vs atleast, up to vs upto.
> -
> -Optional properties:
> -- xlnx,include-sg: Tells whether configured for Scatter-mode in
> -       the hardware.

How about: 'If present, hardware supports scatter-gather mode'
> -
> -Required child node properties:
> -- compatible: It should be either "xlnx,axi-dma-mm2s-channel" or
> -       "xlnx,axi-dma-s2mm-channel".
> -- interrupts: Should contain per channel DMA interrupts.
> -- xlnx,datawidth: Should contain the stream data width, take values
> -       {32,64...1024}.
> -
> -Option child node properties:
> -- xlnx,include-dre: Tells whether hardware is configured for Data
> -       Realignment Engine.

How about: 'If present, hardware supports Data Realignment Engine'

> -
> -Example:
> -++++++++
> -
> -axi_dma_0: axidma at 40400000 {
> -       compatible = "xlnx,axi-dma-1.00.a";
> -       #dma_cells = <1>;

I think you meant #dma-cells = <1>; here. That caught me while testing ;-)

Cheers,

Moritz
