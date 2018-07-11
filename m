From: robh@kernel.org (Rob Herring)
Date: Wed, 11 Jul 2018 10:12:06 -0600
Subject: [PATCH v2 1/2] dt: bindings: Add bindings for SDHCI Synopsys DWC
 MSHC
In-Reply-To: <20180706152047.0b0a4944@xhacker.debian>
References: <20180706151930.78b3024b@xhacker.debian>
 <20180706152047.0b0a4944@xhacker.debian>
Message-ID: <20180711161206.GA1558@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 06, 2018 at 03:20:47PM +0800, Jisheng Zhang wrote:
> Synopsys SDHCI compatible DesignWare Cores Mobile Storage Host
> Controller can support eMMC/SD/SDIO. Add the bindings.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  .../bindings/mmc/sdhci-of-dwcmshc.txt         | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt b/Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt
> new file mode 100644
> index 000000000000..ee4253b33be2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt
> @@ -0,0 +1,20 @@
> +* Synopsys DesignWare Cores Mobile Storage Host Controller
> +
> +Required properties:
> +- compatible: should be one of the following:
> +    "snps,dwcmshc-sdhci"

Needs to note that there must also be an SoC specific compatible.

> +- reg: offset and length of the register set for the device.
> +- interrupts: a single interrupt specifier.
> +- clocks: Array of clocks required for SDHCI; requires at least one for
> +    core clock.
> +- clock-names: Array of names corresponding to clocks property; shall be
> +    "core" for core clock and "bus" for optional bus clock.
> +
> +Example:
> +	sdhci2: sdhci at aa0000 {
> +		compatible = "snps,dwcmshc-sdhci";
> +		reg = <0xaa0000 0x1000>;
> +		interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&emmcclk>;
> +		bus-width = <8>;
> +	}
> -- 
> 2.18.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
