From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 19 Jul 2016 11:37:55 +0100
Subject: [PATCH 01/10] Documentation: DT: qcom_hidma: update binding for
 MSI
In-Reply-To: <1468867177-15007-2-git-send-email-okaya@codeaurora.org>
References: <1468867177-15007-1-git-send-email-okaya@codeaurora.org>
 <1468867177-15007-2-git-send-email-okaya@codeaurora.org>
Message-ID: <20160719103755.GC27022@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 18, 2016 at 02:39:28PM -0400, Sinan Kaya wrote:
> Adding a new binding for qcom,hidma-1.1 to distinguish HW supporting
> MSI interrupts from the older revision.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt b/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt
> index fd5618b..45ce75b 100644
> --- a/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt
> +++ b/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt
> @@ -47,7 +47,8 @@ When the OS is not in control of the management interface (i.e. it's a guest),
>  the channel nodes appear on their own, not under a management node.
>  
>  Required properties:
> -- compatible: must contain "qcom,hidma-1.0"
> +- compatible: must contain "qcom,hidma-1.0" for initial HW or "qcom,hidma-1.1"
> +for MSI capable HW.

Don't we need properties to describe the MSI details (e.g. sideband data
like DeviceID)?

Thanks,
Mark.

>  - reg: Addresses for the transfer and event channel
>  - interrupts: Should contain the event interrupt
>  - desc-count: Number of asynchronous requests this channel can handle
> -- 
> 1.8.2.1
> 
