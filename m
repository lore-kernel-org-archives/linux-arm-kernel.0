From: minghuan.lian@nxp.com (M.h. Lian)
Date: Tue, 20 Nov 2018 11:32:36 +0000
Subject: [PATCHv2 24/25] arm64: dts: freescale: lx2160a: add pcie DT nodes
In-Reply-To: <20181120092615.11680-25-Zhiqiang.Hou@nxp.com>
References: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
 <20181120092615.11680-25-Zhiqiang.Hou@nxp.com>
Message-ID: <HE1PR0401MB22354DD78E9ACB940DBB01A0E8D90@HE1PR0401MB2235.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>

> -----Original Message-----
> From: Z.q. Hou
> Sent: Tuesday, November 20, 2018 5:28 PM
> To: linux-pci at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> devicetree at vger.kernel.org; linux-kernel at vger.kernel.org;
> bhelgaas at google.com; robh+dt at kernel.org; mark.rutland at arm.com;
> l.subrahmanya at mobiveil.co.in; shawnguo at kernel.org; Leo Li
> <leoyang.li@nxp.com>; lorenzo.pieralisi at arm.com;
> catalin.marinas at arm.com; will.deacon at arm.com
> Cc: Mingkai Hu <mingkai.hu@nxp.com>; M.h. Lian
> <minghuan.lian@nxp.com>; Xiaowei Bao <xiaowei.bao@nxp.com>; Z.q. Hou
> <zhiqiang.hou@nxp.com>
> Subject: [PATCHv2 24/25] arm64: dts: freescale: lx2160a: add pcie DT nodes
> 
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> The LX2160A integrated 6 PCIe Gen4 controllers.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - Change the default status of PCIe DT nodes to disabled.
> 
>  .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 163 ++++++++++++++++++
>  1 file changed, 163 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> index a79f5c1ea56d..3a098c462a25 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> @@ -762,5 +762,168 @@
>  				     <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
>  			dma-coherent;
>  		};
> +
> +		pcie at 3400000 {
> +			compatible = "fsl,lx2160a-pcie";
> +			reg = <0x00 0x03400000 0x0 0x00100000   /*
> controller registers */
> +			       0x80 0x00000000 0x0 0x00001000>; /*
> configuration space */
> +			reg-names = "csr_axi_slave", "config_axi_slave";
> +			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /*
> AER interrupt */
> +				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /*
> PME interrupt */
> +				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; /*
> controller interrupt */
> +			interrupt-names = "aer", "pme", "intr";
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			device_type = "pci";
> +			dma-coherent;
> +			apio-wins = <8>;
> +			ppio-wins = <8>;
> +			bus-range = <0x0 0xff>;
> +			ranges = <0x82000000 0x0 0x40000000 0x80
> 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
> +			msi-parent = <&its>;
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 7>;
> +			interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 109
> IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 2 &gic 0 0 GIC_SPI 110
> IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 3 &gic 0 0 GIC_SPI 111
> IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 4 &gic 0 0 GIC_SPI 112
> IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
> +
> +		pcie at 3500000 {
> +			compatible = "fsl,lx2160a-pcie";
> +			reg = <0x00 0x03500000 0x0 0x00100000   /*
> controller registers */
> +			       0x88 0x00000000 0x0 0x00001000>; /*
> configuration space */
> +			reg-names = "csr_axi_slave", "config_axi_slave";
> +			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>, /*
> AER interrupt */
> +				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>, /*
> PME interrupt */
> +				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>; /*
> controller interrupt */
> +			interrupt-names = "aer", "pme", "intr";
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			device_type = "pci";
> +			dma-coherent;
> +			apio-wins = <8>;
> +			ppio-wins = <8>;
> +			bus-range = <0x0 0xff>;
> +			ranges = <0x82000000 0x0 0x40000000 0x88
> 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
> +			msi-parent = <&its>;
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 7>;
> +			interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 114
> IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 2 &gic 0 0 GIC_SPI 115
> IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 3 &gic 0 0 GIC_SPI 116
> IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 4 &gic 0 0 GIC_SPI 117
> IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
> +
> +		pcie at 3600000 {
> +			compatible = "fsl,lx2160a-pcie";
> +			reg = <0x00 0x03600000 0x0 0x00100000   /*
> controller registers */
> +			       0x90 0x00000000 0x0 0x00001000>; /*
> configuration space */
> +			reg-names = "csr_axi_slave", "config_axi_slave";
> +			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>, /*
> AER interrupt */
> +				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>, /*
> PME interrupt */
> +				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>; /*
> controller interrupt */
> +			interrupt-names = "aer", "pme", "intr";
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			device_type = "pci";
> +			dma-coherent;
> +			apio-wins = <8>;
> +			ppio-wins = <8>;
> +			bus-range = <0x0 0xff>;
> +			ranges = <0x82000000 0x0 0x40000000 0x90
> 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
> +			msi-parent = <&its>;
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 7>;
> +			interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 119
> IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 2 &gic 0 0 GIC_SPI 120
> IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 3 &gic 0 0 GIC_SPI 121
> IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 4 &gic 0 0 GIC_SPI 122
> IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
> +
> +		pcie at 3700000 {
> +			compatible = "fsl,lx2160a-pcie";
> +			reg = <0x00 0x03700000 0x0 0x00100000   /*
> controller registers */
> +			       0x98 0x00000000 0x0 0x00001000>; /*
> configuration space */
> +			reg-names = "csr_axi_slave", "config_axi_slave";
> +			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>, /*
> AER interrupt */
> +				     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>, /*
> PME interrupt */
> +				     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>; /*
> controller interrupt */
> +			interrupt-names = "aer", "pme", "intr";
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			device_type = "pci";
> +			dma-coherent;
> +			apio-wins = <8>;
> +			ppio-wins = <8>;
> +			bus-range = <0x0 0xff>;
> +			ranges = <0x82000000 0x0 0x40000000 0x98
> 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
> +			msi-parent = <&its>;
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 7>;
> +			interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 124
> IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 2 &gic 0 0 GIC_SPI 125
> IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 3 &gic 0 0 GIC_SPI 126
> IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 4 &gic 0 0 GIC_SPI 127
> IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
> +
> +		pcie at 3800000 {
> +			compatible = "fsl,lx2160a-pcie";
> +			reg = <0x00 0x03800000 0x0 0x00100000   /*
> controller registers */
> +			       0xa0 0x00000000 0x0 0x00001000>; /*
> configuration space */
> +			reg-names = "csr_axi_slave", "config_axi_slave";
> +			interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>, /*
> AER interrupt */
> +				     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>, /*
> PME interrupt */
> +				     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>; /*
> controller interrupt */
> +			interrupt-names = "aer", "pme", "intr";
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			device_type = "pci";
> +			dma-coherent;
> +			apio-wins = <8>;
> +			ppio-wins = <8>;
> +			bus-range = <0x0 0xff>;
> +			ranges = <0x82000000 0x0 0x40000000 0xa0
> 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
> +			msi-parent = <&its>;
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 7>;
> +			interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 129
> IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 2 &gic 0 0 GIC_SPI 130
> IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 3 &gic 0 0 GIC_SPI 131
> IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 4 &gic 0 0 GIC_SPI 132
> IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
> +
> +		pcie at 3900000 {
> +			compatible = "fsl,lx2160a-pcie";
> +			reg = <0x00 0x03900000 0x0 0x00100000   /*
> controller registers */
> +			       0xa8 0x00000000 0x0 0x00001000>; /*
> configuration space */
> +			reg-names = "csr_axi_slave", "config_axi_slave";
> +			interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>, /*
> AER interrupt */
> +				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>, /*
> PME interrupt */
> +				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>; /*
> controller interrupt */
> +			interrupt-names = "aer", "pme", "intr";
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			device_type = "pci";
> +			dma-coherent;
> +			apio-wins = <8>;
> +			ppio-wins = <8>;
> +			bus-range = <0x0 0xff>;
> +			ranges = <0x82000000 0x0 0x40000000 0xa8
> 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
> +			msi-parent = <&its>;
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 7>;
> +			interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 104
> IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 2 &gic 0 0 GIC_SPI 105
> IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 3 &gic 0 0 GIC_SPI 106
> IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 4 &gic 0 0 GIC_SPI 107
> IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
> +
>  	};
>  };
> --
> 2.17.1
