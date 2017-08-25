From: robh@kernel.org (Rob Herring)
Date: Fri, 25 Aug 2017 13:14:39 -0500
Subject: [PATCH v4 3/4] dt-bindings: PCI: rockchip: Add support for pcie
 wake irq
In-Reply-To: <20170822031934.8675-4-jeffy.chen@rock-chips.com>
References: <20170822031934.8675-1-jeffy.chen@rock-chips.com>
 <20170822031934.8675-4-jeffy.chen@rock-chips.com>
Message-ID: <20170825181439.d3hlwrcbmcss3sx6@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 22, 2017 at 11:19:33AM +0800, Jeffy Chen wrote:
> Add an optional interrupt for PCIE_WAKE pin.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>  .../devicetree/bindings/pci/rockchip-pcie.txt        | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
> index 5678be82530d..9f6504129e80 100644
> --- a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
> @@ -20,10 +20,13 @@ Required properties:
>  - msi-map: Maps a Requester ID to an MSI controller and associated
>  	msi-specifier data. See ./pci-msi.txt
>  - interrupts: Three interrupt entries must be specified.
> -- interrupt-names: Must include the following names
> -	- "sys"
> -	- "legacy"
> -	- "client"
> +- interrupt-names: Include the following names
> +	Required:
> +		- "sys"
> +		- "legacy"
> +		- "client"
> +	Optional:
> +		- "wake"

Use the wakeup source binding:
Documentation/devicetree/bindings/power/wakeup-source.txt

Rob
