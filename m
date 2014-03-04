From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Tue, 4 Mar 2014 15:51:15 -0800
Subject: [PATCH v5] can: xilinx CAN controller support.
In-Reply-To: <5254bfec-c6fd-4681-a34d-706d51e60fbb@VA3EHSMHS004.ehs.local>
References: <5254bfec-c6fd-4681-a34d-706d51e60fbb@VA3EHSMHS004.ehs.local>
Message-ID: <1b9f22ac-4dde-4ecc-885a-3d8081157081@AM1EHSMHS012.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kedar,

On Tue, 2014-03-04 at 06:50PM +0530, Kedareswara rao Appana wrote:
> This patch adds xilinx CAN controller support.
> This driver supports both ZYNQ CANPS and Soft IP
> AXI CAN controller.
> 
[...]
> diff --git a/Documentation/devicetree/bindings/net/can/xilinx_can.txt b/Documentation/devicetree/bindings/net/can/xilinx_can.txt
> new file mode 100644
> index 0000000..0e57103
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/can/xilinx_can.txt
> @@ -0,0 +1,45 @@
> +Xilinx Axi CAN/Zynq CANPS controller Device Tree Bindings
> +---------------------------------------------------------
> +
> +Required properties:
> +- compatible		: Should be "xlnx,zynq-can-1.00.a" for Zynq CAN
> +			  controllers and "xlnx,axi-can-1.00.a" for Axi CAN
> +			  controllers.
> +- reg			: Physical base address and size of the Axi CAN/Zynq
> +			  CANPS registers map.
> +- interrupts		: Property with a value describing the interrupt
> +			  number.
> +- interrupt-parent	: Must be core interrupt controller
> +- clock-names		: List of input clock names - "ref_clk", "aper_clk"

Let's reconsider these names. These are rather Zynq specific names. Does
the IP documentation use these as well? The names should match the
naming used for the IP, rather than the SOC. Is this the correct data sheet:
http://www.xilinx.com/support/documentation/ip_documentation/axi_can/v1_03_a/ds791_axi_can.pdf
? According to that the names should rather be 's_axi_aclk' and
'can_clk', IMHO.

	S?ren
