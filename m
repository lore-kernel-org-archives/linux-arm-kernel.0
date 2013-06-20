From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Jun 2013 15:20:48 +0200
Subject: [PATCH V8 1/4] pci: Add PCIe driver for Samsung Exynos
In-Reply-To: <00db01ce6db3$7f9a3830$7ecea890$@samsung.com>
References: <00db01ce6db3$7f9a3830$7ecea890$@samsung.com>
Message-ID: <201306201520.49212.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 June 2013, Jingoo Han wrote:

> diff --git a/Documentation/devicetree/bindings/pci/exynos-pcie.txt b/Documentation/devicetree/bindings/pci/exynos-pcie.txt
> new file mode 100644
> index 0000000..f71d835
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/exynos-pcie.txt
> @@ -0,0 +1,73 @@
> +* Samsung Exynos PCIe interface

Please adapt the name of the binding as well, and name it snps-dwc-pcie.txt
for instance, to match the change in the driver and in the binding.

> +Required properties:
> +-compatible: should contain "snps,dwc-pcie" to identify the
> +	core, plus an identifier for the specific instance, such
> +	as "samsung,exynos5440-pcie".

Thanks for changing it here.

> +
> +	pcie at 290000 {
> +		compatible = "samsung,exynos5440-pcie";
> +		reg = <0x290000 0x1000
> +			0x270000 0x1000
> +			0x271000 0x40>;


but please also change the example and the .dts files to match.
It should say here

		compatible = "samsung,exynos5440-pcie", "snps,dwc-pcie";

as now required by the binding.

	Arnd
