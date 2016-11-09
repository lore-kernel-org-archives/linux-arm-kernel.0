From: dinguyen@kernel.org (Dinh Nguyen)
Date: Wed, 9 Nov 2016 12:48:21 -0600
Subject: [PATCH] ARM: dts: socfpga: add nand controller nodes
In-Reply-To: <20161109073501.2010-1-s.trumtrar@pengutronix.de>
References: <20161109073501.2010-1-s.trumtrar@pengutronix.de>
Message-ID: <a7127bcd-ec0e-cb47-592d-06f404857d50@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/09/2016 01:35 AM, Steffen Trumtrar wrote:
> Add the denali nand controller to the socfpga dtsi.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>  arch/arm/boot/dts/socfpga.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> index 9f48141270b8..6b0c23ca5e88 100644
> --- a/arch/arm/boot/dts/socfpga.dtsi
> +++ b/arch/arm/boot/dts/socfpga.dtsi
> @@ -700,6 +700,19 @@
>  			status = "disabled";
>  		};
>  
> +		nand0: nand at ff900000 {
> +			#address-cells = <0x1>;
> +			#size-cells = <0x1>;
> +			compatible = "denali,denali-nand-dt";
> +			reg = <0xff900000 0x100000>,
> +			      <0xffb80000 0x10000>;
> +			reg-names = "nand_data", "denali_reg";
> +			interrupts = <0x0 0x90 0x4>;
> +			dma-mask = <0xffffffff>;
> +			clocks = <&nand_clk>;
> +			status = "disabled";
> +		};
> +
>  		ocram: sram at ffff0000 {
>  			compatible = "mmio-sram";
>  			reg = <0xffff0000 0x10000>;
> 

Since there's only 1 NAND node, do we need to call the node "nand0"? No
need to resend a patch, I can change it locally if we agree that the
node should be just:

nand: nand at ff900000

Dinh
