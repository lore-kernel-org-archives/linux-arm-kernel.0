From: robh@kernel.org (Rob Herring)
Date: Fri, 22 Apr 2016 14:37:07 -0500
Subject: [PATCH v2 1/2] Documentation: DT: vdma: Add clock support for vdma
In-Reply-To: <1461152599-28858-1-git-send-email-appanad@xilinx.com>
References: <1461152599-28858-1-git-send-email-appanad@xilinx.com>
Message-ID: <20160422193707.GA16116@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2016 at 05:13:18PM +0530, Kedareswara rao Appana wrote:
> This patch updates the binding doc with clock description
> for vdma.
> 
> Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> ---
> Changes for v2:
> --> Listed down all the clocks supported by the h/w
>     as suggested by the Datta.
> --> Used IP clock names instead of shortcut clock names.
> 
>  Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
> index fcc2b65..afe9eb7 100644
> --- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
> +++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
> @@ -21,6 +21,11 @@ Required properties:
>  - dma-channel child node: Should have at least one channel and can have up to
>  	two channels per device. This node specifies the properties of each
>  	DMA channel (see child node properties below).
> +- clocks: Input clock specifier. Refer to common clock bindings.
> +- clock-names: List of input clocks "s_axi_lite_aclk", "m_axi_mm2s_aclk"
> +	       "m_axi_s2mm_aclk", "m_axis_mm2s_aclk", "s_axis_s2mm_aclk"
> +	       (list of input cloks may vary based on the ip configuration.

s/cloks/clocks/

> +		see clock bindings for more info).

This does not make sense. The common clock binding is going to tell me 
more about how the clocks vary?

You need to define here how the clocks can vary.
