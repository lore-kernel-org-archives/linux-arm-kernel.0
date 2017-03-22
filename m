From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 22 Mar 2017 18:04:30 +0000
Subject: [PATCH] arm64: dts: NS2: Add dma-coherent to relevant DT entries
In-Reply-To: <1490129479-19459-1-git-send-email-jon.mason@broadcom.com>
References: <1490129479-19459-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <779b8bb1-3053-d329-8c53-e428b5ce60be@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On 21/03/17 20:51, Jon Mason wrote:
> Cache related issues with DMA rings and performance issues related to
> caching are being caused by not properly setting the "dma-coherent" flag
> in the device tree entries.  Adding it here to correct the issue.

I'd expect the SMMU to be wired up coherently as well - is it not? (it
won't actually be going wrong if it is, just that you'd be doing
unnecessary cache cleaning on page table updates)

Robin.

> Signed-off-by: Jon Mason <jon.mason@broadcom.com>
> Fixes: fd5e5dd56 ("arm64: dts: Add PCIe0 and PCIe4 DT nodes for NS2")
> Fixes: dddc3c9d7 ("arm64: dts: NS2: add AMAC ethernet support")
> Fixes: e79249143 ("arm64: dts: Add Broadcom Northstar2 device tree entries for PDC driver")
> Fixes: ac9aae00f ("arm64: dts: Add SATA3 AHCI and SATA3 PHY DT nodes for NS2")
> Fixes: efc877676 ("arm64: dts: Add SDHCI DT node for NS2")
> ---
>  arch/arm64/boot/dts/broadcom/ns2.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/broadcom/ns2.dtsi b/arch/arm64/boot/dts/broadcom/ns2.dtsi
> index b8503fc..35a309a 100644
> --- a/arch/arm64/boot/dts/broadcom/ns2.dtsi
> +++ b/arch/arm64/boot/dts/broadcom/ns2.dtsi
> @@ -114,6 +114,7 @@
>  	pcie0: pcie at 20020000 {
>  		compatible = "brcm,iproc-pcie";
>  		reg = <0 0x20020000 0 0x1000>;
> +		dma-coherent;
>  
>  		#interrupt-cells = <1>;
>  		interrupt-map-mask = <0 0 0 0>;
> @@ -144,6 +145,7 @@
>  	pcie4: pcie at 50020000 {
>  		compatible = "brcm,iproc-pcie";
>  		reg = <0 0x50020000 0 0x1000>;
> +		dma-coherent;
>  
>  		#interrupt-cells = <1>;
>  		interrupt-map-mask = <0 0 0 0>;
> @@ -174,6 +176,7 @@
>  	pcie8: pcie at 60c00000 {
>  		compatible = "brcm,iproc-pcie-paxc";
>  		reg = <0 0x60c00000 0 0x1000>;
> +		dma-coherent;
>  		linux,pci-domain = <8>;
>  
>  		bus-range = <0x0 0x1>;
> @@ -203,6 +206,7 @@
>  			      <0x61030000 0x100>;
>  			reg-names = "amac_base", "idm_base", "nicpm_base";
>  			interrupts = <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>;
> +			dma-coherent;
>  			phy-handle = <&gphy0>;
>  			phy-mode = "rgmii";
>  			status = "disabled";
> @@ -213,6 +217,7 @@
>  			reg = <0x612c0000 0x445>;  /* PDC FS0 regs */
>  			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
>  			#mbox-cells = <1>;
> +			dma-coherent;
>  			brcm,rx-status-len = <32>;
>  			brcm,use-bcm-hdr;
>  		};
> @@ -228,6 +233,7 @@
>  			reg = <0x612e0000 0x445>;  /* PDC FS1 regs */
>  			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
>  			#mbox-cells = <1>;
> +			dma-coherent;
>  			brcm,rx-status-len = <32>;
>  			brcm,use-bcm-hdr;
>  		};
> @@ -243,6 +249,7 @@
>  			reg = <0x61300000 0x445>;  /* PDC FS2 regs */
>  			interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
>  			#mbox-cells = <1>;
> +			dma-coherent;
>  			brcm,rx-status-len = <32>;
>  			brcm,use-bcm-hdr;
>  		};
> @@ -258,6 +265,7 @@
>  			reg = <0x61320000 0x445>;  /* PDC FS3 regs */
>  			interrupts = <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
>  			#mbox-cells = <1>;
> +			dma-coherent;
>  			brcm,rx-status-len = <32>;
>  			brcm,use-bcm-hdr;
>  		};
> @@ -668,6 +676,7 @@
>  		sata: ahci at 663f2000 {
>  			compatible = "brcm,iproc-ahci", "generic-ahci";
>  			reg = <0x663f2000 0x1000>;
> +			dma-coherent;
>  			reg-names = "ahci";
>  			interrupts = <GIC_SPI 438 IRQ_TYPE_LEVEL_HIGH>;
>  			#address-cells = <1>;
> @@ -691,6 +700,7 @@
>  			compatible = "brcm,sdhci-iproc-cygnus";
>  			reg = <0x66420000 0x100>;
>  			interrupts = <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>;
> +			dma-coherent;
>  			bus-width = <8>;
>  			clocks = <&genpll_sw BCM_NS2_GENPLL_SW_SDIO_CLK>;
>  			status = "disabled";
> @@ -700,6 +710,7 @@
>  			compatible = "brcm,sdhci-iproc-cygnus";
>  			reg = <0x66430000 0x100>;
>  			interrupts = <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>;
> +			dma-coherent;
>  			bus-width = <8>;
>  			clocks = <&genpll_sw BCM_NS2_GENPLL_SW_SDIO_CLK>;
>  			status = "disabled";
> 
