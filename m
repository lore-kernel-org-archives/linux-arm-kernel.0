From: galak@codeaurora.org (Kumar Gala)
Date: Tue, 29 Oct 2013 03:21:10 -0500
Subject: [PATCH 4/6] edac: Document Krait L1/L2 EDAC driver binding
In-Reply-To: <1383006690-6754-5-git-send-email-sboyd@codeaurora.org>
References: <1383006690-6754-1-git-send-email-sboyd@codeaurora.org>
 <1383006690-6754-5-git-send-email-sboyd@codeaurora.org>
Message-ID: <90D2FDE5-C43F-4ACF-B287-4E0AD8617892@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Oct 28, 2013, at 7:31 PM, Stephen Boyd wrote:

> The Krait L1/L2 error reporting device is made up of two
> interrupts, one per-CPU interrupt for the L1 caches and one
> interrupt for the L2 cache.
> 
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
> .../devicetree/bindings/arm/qcom,krait-cache-erp.txt     | 16 ++++++++++++++++
> 1 file changed, 16 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/arm/qcom,krait-cache-erp.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom,krait-cache-erp.txt b/Documentation/devicetree/bindings/arm/qcom,krait-cache-erp.txt
> new file mode 100644
> index 0000000..01fe8a8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/qcom,krait-cache-erp.txt
> @@ -0,0 +1,16 @@
> +* Qualcomm Krait L1 / L2 cache error reporting
> +
> +Required properties:
> +- compatible: Should be "qcom,krait-cache-erp"
> +- interrupts: Should contain the L1/CPU error interrupt number and
> +  then the L2 cache error interrupt number
> +
> +Optional properties:
> +- interrupt-names: Should contain the interrupt names "l1_irq" and
> +  "l2_irq"
> +
> +Example:
> +	edac {
> +		compatible = "qcom,krait-cache-erp";
> +		interrupts = <1 9 0xf04>, <0 2 0x4>;
> +	};

Why wouldn't we have these as part of cache nodes in the dts?  (which begs the question why we don't have cache nodes?)

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
