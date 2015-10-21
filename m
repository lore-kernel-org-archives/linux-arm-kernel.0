From: w-kwok2@ti.com (Kwok, WingMan)
Date: Wed, 21 Oct 2015 15:14:58 +0000
Subject: [PATCH] ARM: keystone: dts: add PCI serdes driver bindings
In-Reply-To: <1445432242-16129-1-git-send-email-w-kwok2@ti.com>
References: <1445432242-16129-1-git-send-email-w-kwok2@ti.com>
Message-ID: <230CBA6E4B6B6B418E8730AC28E6FC7E04229FCB@DFLE11.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Please ignore the subject patch which is exactly
the same as the one

[PATCH v1] ARM: keystone: dts: add PCI serdes driver bindings

submitted earlier.

Thanks,
WingMan

> -----Original Message-----
> From: Kwok, WingMan
> Sent: Wednesday, October 21, 2015 8:57 AM
> To: robh+dt at kernel.org; pawel.moll at arm.com; mark.rutland at arm.com;
> ijc+devicetree at hellion.org.uk; galak at codeaurora.org; KISHON VIJAY ABRAHAM;
> Quadros, Roger; Karicheri, Muralidharan; bhelgaas at google.com;
> ssantosh at kernel.org; linux at arm.linux.org.uk; devicetree at vger.kernel.org;
> linux-kernel at vger.kernel.org; linux-pci at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org
> Cc: Kwok, WingMan
> Subject: [PATCH] ARM: keystone: dts: add PCI serdes driver bindings
> 
> This patch adds the serdes phy driver dts bindings
> for the keystone PCIe host driver.
> 
> Signed-off-by: WingMan Kwok <w-kwok2@ti.com>
> ---
>  arch/arm/boot/dts/k2e.dtsi      |   10 ++++++++++
>  arch/arm/boot/dts/keystone.dtsi |   10 ++++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/k2e.dtsi b/arch/arm/boot/dts/k2e.dtsi
> index 675fb8e..5f7cc0a 100644
> --- a/arch/arm/boot/dts/k2e.dtsi
> +++ b/arch/arm/boot/dts/k2e.dtsi
> @@ -86,6 +86,15 @@
>  			gpio,syscon-dev = <&devctrl 0x240>;
>  		};
> 
> +		pcie1_phy: phy at 2326000 {
> +			#phy-cells = <0>;
> +			compatible = "ti,keystone-serdes-pcie";
> +			reg = <0x02326000 0x4000>;
> +			link-rate-kbps = <5000000>;
> +			num-lanes = <2>;
> +			status = "disabled";
> +		};
> +
>  		pcie1: pcie at 21020000 {
>  			compatible = "ti,keystone-pcie","snps,dw-pcie";
>  			clocks = <&clkpcie1>;
> @@ -99,6 +108,7 @@
>  			status = "disabled";
>  			device_type = "pci";
>  			num-lanes = <2>;
> +			phys = <&pcie1_phy>;
> 
>  			#interrupt-cells = <1>;
>  			interrupt-map-mask = <0 0 0 7>;
> diff --git a/arch/arm/boot/dts/keystone.dtsi
> b/arch/arm/boot/dts/keystone.dtsi
> index 72816d6..5c7c58a 100644
> --- a/arch/arm/boot/dts/keystone.dtsi
> +++ b/arch/arm/boot/dts/keystone.dtsi
> @@ -275,6 +275,15 @@
>  			ti,syscon-dev = <&devctrl 0x2a0>;
>  		};
> 
> +		pcie0_phy: phy at 2320000 {
> +			#phy-cells = <0>;
> +			compatible = "ti,keystone-serdes-pcie";
> +			reg = <0x02320000 0x4000>;
> +			link-rate-kbps = <5000000>;
> +			num-lanes = <2>;
> +			status = "disabled";
> +		};
> +
>  		pcie0: pcie at 21800000 {
>  			compatible = "ti,keystone-pcie", "snps,dw-pcie";
>  			clocks = <&clkpcie>;
> @@ -288,6 +297,7 @@
>  			status = "disabled";
>  			device_type = "pci";
>  			num-lanes = <2>;
> +			phys = <&pcie0_phy>;
> 
>  			#interrupt-cells = <1>;
>  			interrupt-map-mask = <0 0 0 7>;
> --
> 1.7.9.5
