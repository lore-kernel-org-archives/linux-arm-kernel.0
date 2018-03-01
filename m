From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 1 Mar 2018 14:50:18 +0000
Subject: [PATCH] dt-bindings: PCI: MediaTek: fix dtc warnings
In-Reply-To: <9940757fe2889f46d0de214c5f277bf3c2074205.1518577579.git.ryder.lee@mediatek.com>
References: <9940757fe2889f46d0de214c5f277bf3c2074205.1518577579.git.ryder.lee@mediatek.com>
Message-ID: <20180301145018.GA2516@e107981-ln.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 14, 2018 at 11:27:58AM +0800, Ryder Lee wrote:
> dtc recently added PCI bus checks. Fix these warnings:
> 
> Warning (pci_bridge): Node /pcie at 1a140000/pcie at 0,0 missing bus-range for PCI bridge
> Warning (pci_bridge): Node /pcie at 1a140000/pcie at 1,0 missing bus-range for PCI bridge
> Warning (pci_bridge): Node /pcie at 1a140000/pcie at 2,0 missing bus-range for PCI bridge
> Warning (unit_address_format): Failed prerequisite 'pci_bridge'
> Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
> Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  Documentation/devicetree/bindings/pci/mediatek-pcie.txt | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)

Given that changes to these bindings always went through the PCI tree,
I've applied this patch to pci/mediatek for v4.17, thanks.

Lorenzo

> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie.txt b/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
> index 3a6ce55..20227a8 100644
> --- a/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
> @@ -78,7 +78,7 @@ Examples for MT7623:
>  		#reset-cells = <1>;
>  	};
>  
> -	pcie: pcie-controller at 1a140000 {
> +	pcie: pcie at 1a140000 {
>  		compatible = "mediatek,mt7623-pcie";
>  		device_type = "pci";
>  		reg = <0 0x1a140000 0 0x1000>, /* PCIe shared registers */
> @@ -111,7 +111,6 @@ Examples for MT7623:
>  			  0x83000000 0 0x60000000 0 0x60000000 0 0x10000000>;	/* memory space */
>  
>  		pcie at 0,0 {
> -			device_type = "pci";
>  			reg = <0x0000 0 0 0 0>;
>  			#address-cells = <3>;
>  			#size-cells = <2>;
> @@ -123,7 +122,6 @@ Examples for MT7623:
>  		};
>  
>  		pcie at 1,0 {
> -			device_type = "pci";
>  			reg = <0x0800 0 0 0 0>;
>  			#address-cells = <3>;
>  			#size-cells = <2>;
> @@ -135,7 +133,6 @@ Examples for MT7623:
>  		};
>  
>  		pcie at 2,0 {
> -			device_type = "pci";
>  			reg = <0x1000 0 0 0 0>;
>  			#address-cells = <3>;
>  			#size-cells = <2>;
> @@ -148,6 +145,7 @@ Examples for MT7623:
>  	};
>  
>  Examples for MT2712:
> +
>  	pcie: pcie at 11700000 {
>  		compatible = "mediatek,mt2712-pcie";
>  		device_type = "pci";
> @@ -169,7 +167,6 @@ Examples for MT2712:
>  		ranges = <0x82000000 0 0x20000000  0x0 0x20000000  0 0x10000000>;
>  
>  		pcie0: pcie at 0,0 {
> -			device_type = "pci";
>  			reg = <0x0000 0 0 0 0>;
>  			#address-cells = <3>;
>  			#size-cells = <2>;
> @@ -189,7 +186,6 @@ Examples for MT2712:
>  		};
>  
>  		pcie1: pcie at 1,0 {
> -			device_type = "pci";
>  			reg = <0x0800 0 0 0 0>;
>  			#address-cells = <3>;
>  			#size-cells = <2>;
> @@ -210,6 +206,7 @@ Examples for MT2712:
>  	};
>  
>  Examples for MT7622:
> +
>  	pcie: pcie at 1a140000 {
>  		compatible = "mediatek,mt7622-pcie";
>  		device_type = "pci";
> @@ -243,7 +240,6 @@ Examples for MT7622:
>  		ranges = <0x82000000 0 0x20000000  0x0 0x20000000  0 0x10000000>;
>  
>  		pcie0: pcie at 0,0 {
> -			device_type = "pci";
>  			reg = <0x0000 0 0 0 0>;
>  			#address-cells = <3>;
>  			#size-cells = <2>;
> @@ -263,7 +259,6 @@ Examples for MT7622:
>  		};
>  
>  		pcie1: pcie at 1,0 {
> -			device_type = "pci";
>  			reg = <0x0800 0 0 0 0>;
>  			#address-cells = <3>;
>  			#size-cells = <2>;
> -- 
> 1.9.1
> 
