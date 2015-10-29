From: bhupesh.sharma@freescale.com (Sharma Bhupesh)
Date: Thu, 29 Oct 2015 11:07:41 +0000
Subject: [PATCH 1/1] doc/bindings: Update Layerscape PCIe devicetree
 bindings for LS2080A
In-Reply-To: <1445844681-11488-1-git-send-email-bhupesh.sharma@freescale.com>
References: <1445844681-11488-1-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <BY1PR0301MB130322BA83723F641964E25482200@BY1PR0301MB1303.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

> From: Bhupesh Sharma [mailto:bhupesh.sharma at freescale.com]
> Sent: Monday, October 26, 2015 1:01 PM
> 
> Update the definition of the Layerscape PCI compatible string to add
> support for LS2080A, as the controller on LS2080A is different from
> LS1021A SoC.
> 
> While at it, move the clock related properties in the Designware PCIe
> controller bindings to 'optional' set of properties.
> 
> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Hi Bjorn,
> 
> As discussed with Arnd (http://www.spinics.net/lists/linux-
> clk/msg04092.html),
> this patch depends on a patch that is in your PCI tree but not yet in
> mainline.
> 
> So, sending this to you, so that you can apply the patch on top of the
> other one.

Ping..

> 
>  .../devicetree/bindings/pci/designware-pcie.txt    |   10 +++++-----
>  .../devicetree/bindings/pci/layerscape-pci.txt     |   14 ++++++++++++--
>  2 files changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt
> b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> index 0036ab3..576218a 100644
> --- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> @@ -14,11 +14,6 @@ Required properties:
>  - interrupt-map-mask and interrupt-map: standard PCI properties
>  	to define the mapping of the PCIe interface to interrupt
>  	numbers.
> -- clocks: Must contain an entry for each entry in clock-names.
> -	See ../clocks/clock-bindings.txt for details.
> -- clock-names: Must include the following entries:
> -	- "pcie"
> -	- "pcie_bus"
> 
>  Optional properties:
>  - num-lanes: number of lanes to use (this property should be specified
> unless @@ -27,3 +22,8 @@ Optional properties:
>  - bus-range: PCI bus numbers covered (it is recommended for new
> devicetrees to
>    specify this property, to keep backwards compatibility a range of
> 0x00-0xff
>    is assumed if not present)
> +- clocks: Must contain an entry for each entry in clock-names.
> +	See ../clocks/clock-bindings.txt for details.
> +- clock-names: Must include the following entries:
> +	- "pcie"
> +	- "pcie_bus"
> diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> index 6286f04..ac7e07e 100644
> --- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> @@ -1,10 +1,20 @@
>  Freescale Layerscape PCIe controller
> 
> -This PCIe host controller is based on the Synopsis Designware PCIe IP
> +This PCIe host controller is based on the Synopsys Designware PCIe IP
>  and thus inherits all the common properties defined in designware-
> pcie.txt.
> 
> +This controller derives its clocks from the Reset Configuration Word
> +(RCW) which is used to describe the PLL settings at the time of chip-
> reset.
> +
> +Also as per the available Reference Manuals, there is no specific
> 'version'
> +register available in the Freescale PCIe controller register set, which
> +can allow determining the underlying Designware PCIe controller version
> +information.
> +
>  Required properties:
> -- compatible: should contain the platform identifier such as
> "fsl,ls1021a-pcie"
> +- compatible: should contain the platform identifier such as:
> +        "fsl,ls1021a-pcie", "snps,dw-pcie"
> +        "fsl,ls2080a-pcie", "snps,dw-pcie"
>  - reg: base addresses and lengths of the PCIe controller
>  - interrupts: A list of interrupt outputs of the controller. Must
> contain an
>    entry for each entry in the interrupt-names property.
> --
> 1.7.9.5
> 

Regards,
Bhupesh
