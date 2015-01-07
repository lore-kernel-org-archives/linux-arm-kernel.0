From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 07 Jan 2015 09:30:45 +0100
Subject: [PATCH 2/4] Documentation: dt-bindings: Add the binding info for
 APM X-Gene PCIe DMA driver
In-Reply-To: <1420608537-12296-3-git-send-email-mchitale@apm.com>
References: <1420608537-12296-1-git-send-email-mchitale@apm.com>
 <1420608537-12296-3-git-send-email-mchitale@apm.com>
Message-ID: <2098807.VbUeJKFBVr@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 January 2015 10:58:55 Mayuresh Chitale wrote:
> +Required properties:
> +- compatible :
> +       - "apm,xgene-pciedma" for pcie DMA on X-Gene SoC
> +- interrupts : An interrupt-specifier which is used to handle DMA interrupts
> +
> +Examples:
> +               pciedma0 {
> +                       status = "disabled";
> +                       compatible = "apm,xgene-pciedma";
> +                       reg = < 0x0 0x1F2B0154 0x0 0xC
> +                               0x0 0x1F2B0058 0x0 0x8>;
> +                       reg-names = "cfg", "intr";
> +                       interrupts = <0x0 0xC6 0x4>;
> +               };
> 

The example contains a "reg-names" property that is neither listed
as optional nor mandatory, and that is not used by the driver.
Bettter drop that from the example.

The 'reg' property is not documented in the binding. Please
document which register each index refers to.

	Arnd
