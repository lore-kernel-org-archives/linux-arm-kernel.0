From: robh@kernel.org (Rob Herring)
Date: Tue, 15 Sep 2015 14:43:53 -0500
Subject: [PATCH v9 5/6] Documentation: DT: Add HiSilicon PCIe host binding
In-Reply-To: <1442321361-174300-6-git-send-email-wangzhou1@hisilicon.com>
References: <1442321361-174300-1-git-send-email-wangzhou1@hisilicon.com>
 <1442321361-174300-6-git-send-email-wangzhou1@hisilicon.com>
Message-ID: <55F874F9.1060804@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/15/2015 07:49 AM, Zhou Wang wrote:
> This patch adds related DTS binding document for HiSilicon PCIe host driver.
> 
> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
> ---
>  .../devicetree/bindings/pci/hisilicon-pcie.txt     | 46 ++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> new file mode 100644
> index 0000000..2afc9d1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> @@ -0,0 +1,46 @@
> +HiSilicon PCIe host bridge DT description
> +
> +HiSilicon PCIe host controller is based on Designware PCI core.
> +It shares common functions with PCIe Designware core driver and inherits
> +common properties defined in
> +Documentation/devicetree/bindings/pci/designware-pci.txt.
> +
> +Additional properties are described here:
> +
> +Required properties:
> +- compatible: Should contain "hisilicon,hip05-pcie".
> +- reg: Should contain rc_dbi, subctrl, config registers location and length.
> +- reg-names: Must include the following entries:
> +  "rc_dbi": controller configuration registers;
> +  "subctrl": whole PCIe hosts configuration registers;
> +  "config": PCIe configuration space registers.
> +- msi-parent: Should be its_pcie which is an ITS receiving MSI interrupts.
> +- port-id: Should be 0, 1, 2 or 3.

What is port-id for? Use of instance indexes need to have good reason.

Rob
