From: robh@kernel.org (Rob Herring)
Date: Fri, 23 Sep 2016 10:39:10 -0500
Subject: [PATCH V3 01/10] Documentation: DT: qcom_hidma: update binding
 for MSI
In-Reply-To: <1473960166-30155-2-git-send-email-okaya@codeaurora.org>
References: <1473960166-30155-1-git-send-email-okaya@codeaurora.org>
 <1473960166-30155-2-git-send-email-okaya@codeaurora.org>
Message-ID: <20160923153910.GA23150@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 15, 2016 at 01:22:37PM -0400, Sinan Kaya wrote:
> Adding a new binding for qcom,hidma-1.1 to distinguish HW supporting
> MSI interrupts from the older revision.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt b/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt
> index fd5618b..47bfb5a 100644
> --- a/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt
> +++ b/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt
> @@ -47,12 +47,23 @@ When the OS is not in control of the management interface (i.e. it's a guest),
>  the channel nodes appear on their own, not under a management node.
>  
>  Required properties:
> -- compatible: must contain "qcom,hidma-1.0"
> +- compatible: must contain "qcom,hidma-1.0" for initial HW or "qcom,hidma-1.1"
> +for MSI capable HW.

Do you have an SoC part number yet? If so, please use that instead.

>  - reg: Addresses for the transfer and event channel
>  - interrupts: Should contain the event interrupt
>  - desc-count: Number of asynchronous requests this channel can handle
>  - iommus: required a iommu node
>  
> +Optional properties for MSI:
> +- msi-parent: pointer to the MSI controller object with the DeviceID in use.
> +
> +Example:
> + msi_parent: <&msi0 0x80024>
> +
> +msi0 is the MSI controller in the system. Bits 0-5 is the channel ID. 4
> +is the channel ID. Bits 5-8 is the instance number. This is for the HIDMA
> +instance 1.
> +
>  Example:
>  
>  Hypervisor OS configuration:
> -- 
> 1.9.1
> 
