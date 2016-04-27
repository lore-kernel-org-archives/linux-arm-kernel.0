From: lars@metafoo.de (Lars-Peter Clausen)
Date: Wed, 27 Apr 2016 09:11:46 +0200
Subject: [PATCH v7 1/2] Documentation: DT: dma: Add Xilinx zynqmp dma
 device tree binding documentation
In-Reply-To: <1461740729-30715-1-git-send-email-appanad@xilinx.com>
References: <1461740729-30715-1-git-send-email-appanad@xilinx.com>
Message-ID: <57206632.7010508@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/27/2016 09:05 AM, Kedareswara rao Appana wrote:
[...]
> +- xlnx,include-sg	: Indicates the controller to operate in simple or
> +			  scatter gather dma mode
> +- xlnx,ratectrl		: Scheduling interval in terms of clock cycles for
> +			  source AXI transaction
> +- xlnx,overfetch	: Tells whether the channel is allowed to over
> +			  fetch the data
> +- xlnx,src-issue	: Number of AXI outstanding transactions on source side
> +- xlnx,src-burst-len	: AXI length for data read. Support only power of
> +			  2 byte values.
> +- xlnx,dst-burst-len	: AXI length for data write. Support only power of

These are all software runtime configuration parameters that you'd want to
change at runtime depending on which peripheral you are targeting with a
specific DMA transfer. These really do not belong into the devicetree.
