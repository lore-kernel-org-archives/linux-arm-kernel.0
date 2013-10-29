From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 28 Oct 2013 23:18:35 -0700
Subject: [PATCH 2/2] dmaengine: msm_bam_dma: Add device tree binding
In-Reply-To: <1382732643-8184-3-git-send-email-agross@codeaurora.org>
References: <1382732643-8184-1-git-send-email-agross@codeaurora.org>
 <1382732643-8184-3-git-send-email-agross@codeaurora.org>
Message-ID: <20131029061835.GE21983@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/25, Andy Gross wrote:
> diff --git a/Documentation/devicetree/bindings/dma/msm_bam_dma.txt b/Documentation/devicetree/bindings/dma/msm_bam_dma.txt
> new file mode 100644
> index 0000000..fe3ed8f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/msm_bam_dma.txt
> @@ -0,0 +1,49 @@
> +MSM BAM DMA controller
> +
> +Required properties:
> +- compatible: Should be "qcom,bam"
> +- reg: Address range for DMA registers
> +- interrupts: single interrupt for this controller
> +- #dma-cells: must be <3>
> +- clocks: required clock
> +- clock-names: name of clock
> +
> +Example:
> +
> +	dma0: dma at f9984000 = {

I imagine it's fine to say 'bam0: dma at f9984000' here. The node
name should stay dma though. This way we know that we're talking
about the first bam. Or if there is a more specific name for the
bam we could use that, like system-bam or sdhci-bam.

> +		compatible = "qcom,bam";
> +		reg = <0xf9984000 0x15000>;
> +		interrupts = <0 94 0>;
> +		clocks = <&bam_dma_ahb_cxc>;
> +		clock-names = "bam_clk";
> +		#dma-cells = <3>;
> +	};
> +
> +Client:
> +Required properties:
> +- dmas: List of dma channel requests
> +- dma-names: Names of aforementioned requested channels
> +
> +Clients must use the format described in the dma.txt file, using a four cell
> +specifier for each channel.
> +
> +The four cells in order are:
> +  1. A phandle pointing to the DMA controller
> +  2. The channel number
> +  3. The execution environment value for this channel.
> +  4. Direction of the fixed unidirectional channel
> +     0 - Memory to Device
> +     1 - Device to Memory

Should we add "2 - Device to Device" here? Is there anything more
that needs to be done in the binding for device to device
transfers.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
