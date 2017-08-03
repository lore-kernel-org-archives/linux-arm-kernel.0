From: helgaas@kernel.org (Bjorn Helgaas)
Date: Thu, 3 Aug 2017 17:17:28 -0500
Subject: [PATCH v2 3/5] dt-bindings: PCI: rename and cleanup MediaTek
 binding text
In-Reply-To: <309532ded49d3452a609116d1c421d820bea74e4.1501122135.git.honghui.zhang@mediatek.com>
References: <cover.1501122135.git.honghui.zhang@mediatek.com>
 <309532ded49d3452a609116d1c421d820bea74e4.1501122135.git.honghui.zhang@mediatek.com>
Message-ID: <20170803221728.GM20308@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 27, 2017 at 10:58:37AM +0800, honghui.zhang at mediatek.com wrote:
> From: Ryder Lee <ryder.lee@mediatek.com>
> 
> In order to accommodate other SoC generations, this patch updates filename
> to make it more generic, regroups specific properties by SoCs, and removes
> redundant descriptions.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  ...{mediatek,mt7623-pcie.txt => mediatek-pcie.txt} | 29 +++++++++++-----------
>  1 file changed, 14 insertions(+), 15 deletions(-)
>  rename Documentation/devicetree/bindings/pci/{mediatek,mt7623-pcie.txt => mediatek-pcie.txt} (91%)
> 
> diff --git a/Documentation/devicetree/bindings/pci/mediatek,mt7623-pcie.txt b/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
> similarity index 91%
> rename from Documentation/devicetree/bindings/pci/mediatek,mt7623-pcie.txt
> rename to Documentation/devicetree/bindings/pci/mediatek-pcie.txt
> index fe80dda..a968f25 100644
> --- a/Documentation/devicetree/bindings/pci/mediatek,mt7623-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
> @@ -1,18 +1,13 @@
> -MediaTek Gen2 PCIe controller which is available on MT7623 series SoCs
> -
> -PCIe subsys supports single root complex (RC) with 3 Root Ports. Each root
> -ports supports a Gen2 1-lane Link and has PIPE interface to PHY.
> +MediaTek Gen2 PCIe controller
>  
>  Required properties:
> -- compatible: Should contain "mediatek,mt7623-pcie".
> +- compatible: Should contain one of the following string:

s/string/strings/

> +	"mediatek,mt2701-pcie"
> +	"mediatek,mt7623-pcie"
