From: robh@kernel.org (Rob Herring)
Date: Mon, 4 Dec 2017 16:14:14 -0600
Subject: [PATCH V5 1/7] Documentation: DT: qcom_hidma: Bump HW revision
 for the bugfixed HW
In-Reply-To: <1512188864-773-2-git-send-email-okaya@codeaurora.org>
References: <1512188864-773-1-git-send-email-okaya@codeaurora.org>
 <1512188864-773-2-git-send-email-okaya@codeaurora.org>
Message-ID: <20171204221414.f5tphhn7gvlle3li@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 01, 2017 at 11:27:38PM -0500, Sinan Kaya wrote:
> A new version of the HIDMA IP has been released with bug fixes. Bumping the
> hardware version to differentiate from others.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt b/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt
> index 55492c2..5d93d6d 100644
> --- a/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt
> +++ b/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt
> @@ -47,8 +47,8 @@ When the OS is not in control of the management interface (i.e. it's a guest),
>  the channel nodes appear on their own, not under a management node.
>  
>  Required properties:
> -- compatible: must contain "qcom,hidma-1.0" for initial HW or "qcom,hidma-1.1"
> -for MSI capable HW.
> +- compatible: must contain "qcom,hidma-1.0" for initial HW or
> +  "qcom,hidma-1.1"/"qcom,hidma-1.2" for MSI capable HW.

Hopefully 1.2 corresponds to some actual version numbering and not just 
something you made up. I'd really rather have SoC based compatible 
strings unless you have dozens of SoCs for each version. I'll probably 
just say the same thing again when 1.3 or 2.0 gets added...

Reviewed-by: Rob Herring <robh@kernel.org>

>  - reg: Addresses for the transfer and event channel
>  - interrupts: Should contain the event interrupt
>  - desc-count: Number of asynchronous requests this channel can handle
> -- 
> 1.9.1
> 
