From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 17 Dec 2014 23:01:27 +0100
Subject: [PATCH 2/5] PCI: st: Add Device Tree bindings for sti pcie
In-Reply-To: <1418812486-12394-3-git-send-email-gabriel.fernandez@linaro.org>
References: <1418812486-12394-1-git-send-email-gabriel.fernandez@linaro.org>
 <1418812486-12394-3-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <2165161.8vJctS1yVa@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 17 December 2014 11:34:43 Gabriel FERNANDEZ wrote:
> sti pcie is built around a Synopsis Designware PCIe IP.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/st-pcie.txt | 53 +++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/st-pcie.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/st-pcie.txt b/Documentation/devicetree/bindings/pci/st-pcie.txt
> new file mode 100644
> index 0000000..bd3488f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/st-pcie.txt
> @@ -0,0 +1,53 @@
> +STMicroelectronics STi PCIe controller
> +
> +This PCIe host controller is based on the Synopsis Designware PCIe IP
> +and thus inherits all the common properties defined in designware-pcie.txt.
> +
> +Required properties:
> + - compatible: "st,stih407-pcie"
> + - reg: base address and length of the pcie controller, mem-window address
> +   and length available to the controller.
> + - interrupts: A list of interrupt outputs of the controller.
> + - interrupt-names: Must include the following entries:
> +   "msi": STi interrupt that is asserted when an MSI is received

You should specify that only one interrupt may be present.
If you extend the binding, you will need to describe what the
second one is as well.

> + - st,syscfg : should be a phandle of the syscfg node. Also contains syscfg
> +   offset for IP configuration.
> + - resets, reset-names: the power-down and soft-reset lines of PCIe IP.
> +   Associated names must be "powerdown" and "softreset".
> + - phys, phy-names: the phandle for the PHY device.
> +   Associated name must be "pcie_phy"

Names should not have underscores in them in general. "pcie-phy" would
be fine, but just "pcie" seems good enough, unless there are existing
drivers that have established a specific naming.


	Arnd
