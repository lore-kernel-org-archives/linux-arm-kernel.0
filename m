From: shubhrajyoti.datta@gmail.com (Shubhrajyoti Datta)
Date: Wed, 20 Apr 2016 13:29:32 +0530
Subject: [PATCH 1/2] Documentation: DT: vdma: Add clock support for vdma
In-Reply-To: <1461136800-20334-1-git-send-email-appanad@xilinx.com>
References: <1461136800-20334-1-git-send-email-appanad@xilinx.com>
Message-ID: <CAKfKVtEkfnDqU476troXmCw20ATvQvj-JdPX-BCuPDR-9ZxKHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2016 at 12:49 PM, Kedareswara rao Appana
<appana.durga.rao@xilinx.com> wrote:
> This patch updates the binding doc with clock description
> for vdma.
>
> Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> ---
>  Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
> index fcc2b65..e1c9019 100644
> --- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
> +++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
> @@ -21,6 +21,10 @@ Required properties:
>  - dma-channel child node: Should have at least one channel and can have up to
>         two channels per device. This node specifies the properties of each
>         DMA channel (see child node properties below).
> +- clocks: Input clock specifier. Refer to common clock bindings.
> +- clock-names: List of input clocks "axi_clk", "tx_clk", "txs_clk" (list of input
> +              cloks may vary based on the ip configuration. see clock bindings
> +              for more info).
>
>  Required properties for VDMA:
>  - xlnx,num-fstores: Should be the number of framebuffers as configured in h/w.
> @@ -60,6 +64,8 @@ axi_vdma_0: axivdma at 40030000 {
>         xlnx,num-fstores = <0x8>;
>         xlnx,flush-fsync = <0x1>;
>         xlnx,addrwidth = <0x20>;
> +       clocks = <&clk 0>, <&clk 1>, <&clk 2>;
> +       clock-names = "axi_clk", "tx_clk", "txs_clk";

the module has
s_axi_lite_aclk Clock I AXI VDMA AXI4-Lite interface clock
 m_axi_mm2s_aclk Clock I AXI VDMA MM2S clock
 m_axi_s2mm_aclk Clock I AXI VDMA S2MM clock
 m_axis_mm2s_aclk Clock I AXI VDMA MM2S AXIS clock
 s_axis_s2mm_aclk Clock I AXI VDMA S2MM AXIS clock

I think a partial support is not wrong.
however  we should keep the names same as the TRM.


>         dma-channel at 40030000 {
>                 compatible = "xlnx,axi-vdma-mm2s-channel";
>                 interrupts = < 0 54 4 >;
> --
> 2.1.2
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
