From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 22 Nov 2018 11:28:09 +0000
Subject: [PATCH 2/4] doc/layerscape-pci: removed unsuitable compatible
 string
In-Reply-To: <20181008031428.25293-3-Zhiqiang.Hou@nxp.com>
References: <20181008031428.25293-1-Zhiqiang.Hou@nxp.com>
 <20181008031428.25293-3-Zhiqiang.Hou@nxp.com>
Message-ID: <20181122112809.GA11952@e107981-ln.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 08, 2018 at 11:14:26AM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Removed the compatible string "snps,dw-pcie", it is for the reference
> platform driver for PCI RC IP Protoyping Kits based on the ARC SDP,
> so it is not suitable for all platform with designware PCIe controller,
> and platform vendors have themselves' drivers.
> 
> The compatible string "snsp,dw-pcie" was added by mistake and it's not
> matched that time, but it is matched because pcie drivers has been
> collected recently.

I do not understand what you mean, please explain it to me and I will
update the commit log accordingly before merging it.

Lorenzo

> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
>  Documentation/devicetree/bindings/pci/layerscape-pci.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> index 5eb1c202932f..9b2b8d66d1f4 100644
> --- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> @@ -13,8 +13,8 @@ information.
>  
>  Required properties:
>  - compatible: should contain the platform identifier such as:
> -        "fsl,ls1021a-pcie", "snps,dw-pcie"
> -        "fsl,ls2080a-pcie", "fsl,ls2085a-pcie", "snps,dw-pcie"
> +        "fsl,ls1021a-pcie"
> +        "fsl,ls2080a-pcie", "fsl,ls2085a-pcie"
>          "fsl,ls2088a-pcie"
>          "fsl,ls1088a-pcie"
>          "fsl,ls1046a-pcie"
> @@ -36,7 +36,7 @@ Required properties:
>  Example:
>  
>  	pcie at 3400000 {
> -		compatible = "fsl,ls1021a-pcie", "snps,dw-pcie";
> +		compatible = "fsl,ls1021a-pcie";
>  		reg = <0x00 0x03400000 0x0 0x00010000   /* controller registers */
>  		       0x40 0x00000000 0x0 0x00002000>; /* configuration space */
>  		reg-names = "regs", "config";
> -- 
> 2.17.1
> 
