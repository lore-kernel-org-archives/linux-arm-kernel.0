From: helgaas@kernel.org (Bjorn Helgaas)
Date: Wed, 22 Jun 2016 11:16:56 -0500
Subject: [PATCH v2 1/3] dt-bindings: add DT binding for the Aardvark PCIe
 controller
In-Reply-To: <1465574056-8787-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1465574056-8787-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1465574056-8787-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20160622161656.GE25485@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 10, 2016 at 05:54:14PM +0200, Thomas Petazzoni wrote:
> This commit adds the documentation for the Device Tree binding used to
> describe the Aardvark PCIe controller, found on Marvell Armada 3700
> ARM64 SoCs.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  .../devicetree/bindings/pci/aardvark-pci.txt       | 56 ++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/aardvark-pci.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/aardvark-pci.txt b/Documentation/devicetree/bindings/pci/aardvark-pci.txt
> new file mode 100644
> index 0000000..683830d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/aardvark-pci.txt
> @@ -0,0 +1,56 @@
> +Aardvark PCIe controller
> +
> +This PCIe controller is used on the Marvell Armada 3700 ARM64 SoC.
> +
> +The Device Tree node describing an Aardvark PCIe controller must
> +contain the following properties:
> +
> + - compatible: Should be "marvell,armada-3700-pcie"
> + - reg: range of registers for the PCIe controller
> + - interrupts: the interrupt line of the PCIe controller
> + - #address-cells: set to <3>
> + - #size-cells: set to <2>
> + - device_type: set to "pci"
> + - ranges: ranges for the PCI memory and I/O regions
> + - #interrupt-cells: set to <1>
> + - msi-controller: indicates that the PCIe controller can itself
> +   handled MSI interrupts

s/handled/handle/
