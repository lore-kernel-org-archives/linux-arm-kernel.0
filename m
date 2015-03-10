From: joshc@ni.com (Josh Cartwright)
Date: Tue, 10 Mar 2015 18:57:51 -0500
Subject: [PATCH] dma: Add Xilinx ZDMA device tree Binding Documentation
In-Reply-To: <BN1AFFO11FD032F933FA09686353911532C8180@BN1AFFO11FD032.protection.gbl>
References: <BN1AFFO11FD032F933FA09686353911532C8180@BN1AFFO11FD032.protection.gbl>
Message-ID: <20150310235751.GC27583@jcartwri.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 10, 2015 at 07:46:23PM +0530, Punnaiah Choudary Kalluri wrote:
> Device-tree binding documentation for Xilinx ZDMA Engine
> 
> Signed-off-by: Punnaiah Choudary Kalluri <punnaia@xilinx.com>
> ---

Hey Punnaiah-

Was this intended to be sent out with a driver?

>  .../devicetree/bindings/dma/xilinx/zdma.txt        |   76 ++++++++++++++++++++
>  1 files changed, 76 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/xilinx/zdma.txt
> 
> diff --git a/Documentation/devicetree/bindings/dma/xilinx/zdma.txt b/Documentation/devicetree/bindings/dma/xilinx/zdma.txt
> new file mode 100644
> index 0000000..399a3bc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/xilinx/zdma.txt
> @@ -0,0 +1,76 @@
> +Xilinx ZDMA engine, it does support memory to memory transfers,
> +memory to device and device to memory transfers. It also has flow
> +control and rate control support for slave/peripheral dma access.
> +
> +Xilinx ZynqMP has two instances of general purpose DMA(ZDMA).
> +one is located in FPD(full power domain) and other is located in
> +LPD(low power domain).
> +
> +ZDMA instance located in FPD is referred as FPDMA and instance located
> +in LPD is referred as LPDMA.
> +
> +FPDMA is configured with 8 DMA channels and AXI bus width is 128 byte.
> +LPDMA is configured with 8 DMA channels and AXI bus width is 64 byte.
> +
> +Each channel in a instance has its own address space and interrupt line
                   ^an

> +but shares common reference and APB clock. So, each channel will be treated
> +as a standalone dma device.

Does your example below then describe only a single channel?  Or, should
I expect to see sub-nodes representing each of the dma channels?

> +Since its a general purpose dma controller, it has a rich set of configurable
> +options with respect to data and descriptor attributes.
> +
> +Required properties:
> +- compatible: Should be "xlnx,fpdma-1.0" or "xlnx,lpdma-1.0"
> +- reg: Memory map for dma module access.
> +- interrupt-parent: Interrupt controller the interrupt is routed through
> +- interrupts: Should contain DMA channel interrupt.
> +- xlnx,id: Channel Id

I would have expected, as a dma controller, to see a #dma-cells here,
and a tie-in to the existing Documentation/devicetree/bindings/dma/dma.txt documentation.

  Josh
