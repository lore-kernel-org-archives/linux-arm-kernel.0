From: minghuan.lian@nxp.com (Minghuan Lian)
Date: Tue, 2 Feb 2016 08:48:36 +0000
Subject: [PATCH 1/4] ARM: dts: ls1021a: add PCIe dts node
In-Reply-To: <1454401807-28751-1-git-send-email-Minghuan.Lian@nxp.com>
References: <1454401807-28751-1-git-send-email-Minghuan.Lian@nxp.com>
Message-ID: <VI1PR04MB1615DCF54369ED2E01234E64E8DF0@VI1PR04MB1615.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Could you please help to review the patch?  Thank you very much.
There is only one patch not a set of patch, please ignore [1/4] :(

Arnd has given a ack.


Thanks,
Minghuan
 

> -----Original Message-----
> From: Minghuan Lian [mailto:Minghuan.Lian at nxp.com]
> Sent: Tuesday, February 02, 2016 4:30 PM
> To: linux-pci at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org; Roy Zang <roy.zang@nxp.com>;
> Mingkai Hu <mingkai.hu@nxp.com>; Stuart Yoder <stuart.yoder@nxp.com>;
> Yang-Leo Li <leoyang.li@nxp.com>; Arnd Bergmann <arnd@arndb.de>; Bjorn
> Helgaas <bhelgaas@google.com>; Minghuan Lian <minghuan.lian@nxp.com>
> Subject: [PATCH 1/4] ARM: dts: ls1021a: add PCIe dts node
> 
> LS1021a contains two PCIe controllers. The patch adds their node to dts file.
> 
> Signed-off-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> ---
>  arch/arm/boot/dts/ls1021a.dtsi | 44
> ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
> index 2c84ca2..274d647 100644
> --- a/arch/arm/boot/dts/ls1021a.dtsi
> +++ b/arch/arm/boot/dts/ls1021a.dtsi
> @@ -560,5 +560,49 @@
>  			dr_mode = "host";
>  			snps,quirk-frame-length-adjustment = <0x20>;
>  		};
> +
> +		pcie at 3400000 {
> +			compatible = "fsl,ls1021a-pcie", "snps,dw-pcie";
> +			reg = <0x00 0x03400000 0x0 0x00010000   /* controller
> registers */
> +			       0x40 0x00000000 0x0 0x00002000>; /* configuration
> space */
> +			reg-names = "regs", "config";
> +			interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>; /*
> controller interrupt */
> +			fsl,pcie-scfg = <&scfg 0>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			device_type = "pci";
> +			num-lanes = <4>;
> +			bus-range = <0x0 0xff>;
> +			ranges = <0x81000000 0x0 0x00000000 0x40 0x00010000 0x0
> 0x00010000   /* downstream I/O */
> +				  0x82000000 0x0 0x40000000 0x40 0x40000000 0x0
> 0x40000000>; /* non-prefetchable memory */
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 7>;
> +			interrupt-map = <0000 0 0 1 &gic GIC_SPI 91
> IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 2 &gic GIC_SPI 188
> IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 3 &gic GIC_SPI 190
> IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 4 &gic GIC_SPI 192
> IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		pcie at 3500000 {
> +			compatible = "fsl,ls1021a-pcie", "snps,dw-pcie";
> +			reg = <0x00 0x03500000 0x0 0x00010000   /* controller
> registers */
> +			       0x48 0x00000000 0x0 0x00002000>; /* configuration
> space */
> +			reg-names = "regs", "config";
> +			interrupts = <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
> +			fsl,pcie-scfg = <&scfg 1>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			device_type = "pci";
> +			num-lanes = <4>;
> +			bus-range = <0x0 0xff>;
> +			ranges = <0x81000000 0x0 0x00000000 0x48 0x00010000 0x0
> 0x00010000   /* downstream I/O */
> +				  0x82000000 0x0 0x40000000 0x48 0x40000000 0x0
> 0x40000000>; /* non-prefetchable memory */
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 7>;
> +			interrupt-map = <0000 0 0 1 &gic GIC_SPI 92
> IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 2 &gic GIC_SPI 189
> IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 3 &gic GIC_SPI 191
> IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 4 &gic GIC_SPI 193
> IRQ_TYPE_LEVEL_HIGH>;
> +		};
>  	};
>  };
> --
> 1.9.1
