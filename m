From: lars@metafoo.de (Lars-Peter Clausen)
Date: Mon, 24 Aug 2015 15:47:09 +0200
Subject: [PATCH v4 1/2] Documentation: dt: Add Xilinx zynqmp dma device
 tree binding documentation
In-Reply-To: <1438831173-8761-1-git-send-email-punnaia@xilinx.com>
References: <1438831173-8761-1-git-send-email-punnaia@xilinx.com>
Message-ID: <55DB205D.7090802@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/06/2015 05:19 AM, Punnaiah Choudary Kalluri wrote:
[...]
> +Optional properties:
> +- xlnx,include-sg: Indicates the controller to operate in simple or scatter
> +		   gather dma mode
> +- xlnx,ratectrl: Scheduling interval in terms of clock cycles for
> +		 source AXI transaction
> +- xlnx,overfetch: Tells whether the channel is allowed to over fetch the data
> +- xlnx,src-issue: Number of AXI outstanding transactions on source side
> +- xlnx,desc-axi-cohrnt: Tells whether the AXI transactions generated for the
> +			descriptor read are marked Non-coherent
> +- xlnx,src-axi-cohrnt: Tells whether the AXI transactions generated for the
> +			source descriptor payload are marked Non-coherent
> +- xlnx,dst-axi-cohrnt: Tells whether the AXI transactions generated for the
> +			dst descriptor payload are marked Non-coherent
> +- xlnx,desc-axi-qos: AXI QOS bits to be used for descriptor fetch
> +- xlnx,src-axi-qos: AXI QOS bits to be used for data read
> +- xlnx,dst-axi-qos: AXI QOS bits to be used for data write
> +- xlnx,desc-axi-cache: AXI cache bits to be used for descriptor fetch.
> +- xlnx,desc-axi-cache: AXI cache bits to be used for data read
> +- xlnx,desc-axi-cache: AXI cache bits to be used for data write
> +- xlnx,src-burst-len: AXI length for data read. Support only power of 2 values
> +		      i.e 1,2,4,8 and 16
> +- xlnx,dst-burst-len: AXI length for data write. Support only power of 2 values
> +		      i.e 1,2,4,8 and 16

None of these really belong into the devicetree. This is all runtime
configuration data.

- Lars
