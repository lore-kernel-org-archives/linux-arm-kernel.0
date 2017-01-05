From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Thu, 05 Jan 2017 09:55:56 +0100
Subject: [PATCH 08/12] ARM: dts: socfpga: Add NAND device tree for Arria10
In-Reply-To: <1483575694-29599-9-git-send-email-dinguyen@kernel.org>
References: <1483575694-29599-1-git-send-email-dinguyen@kernel.org>
 <1483575694-29599-9-git-send-email-dinguyen@kernel.org>
Message-ID: <73a8b5ga1v.fsf@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi!

Dinh Nguyen <dinguyen@kernel.org> writes:

> From: Graham Moore <grmoore@opensource.altera.com>
>
> Add socfpga_arria10_socdk_nand.dts board file for supporting NAND.
>
> Signed-off-by: Graham Moore <grmoore@opensource.altera.com>
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
>  arch/arm/boot/dts/Makefile                       |  1 +
>  arch/arm/boot/dts/socfpga_arria10_socdk_nand.dts | 44 ++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
>  create mode 100644 arch/arm/boot/dts/socfpga_arria10_socdk_nand.dts
>

(...)

> +#include "socfpga_arria10_socdk.dtsi"
> +
> +/ {
> +	soc {
> +		nand: nand at ffb90000 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			status = "okay";
> +
> +			compatible = "denali,denali-nand-dt", "altr,socfpga-denali-nand";
> +			reg = <0xffb90000 0x72000>, <0xffb80000 0x10000>;
> +			reg-names = "nand_data", "denali_reg";
> +			interrupts = <0 99 4>;
> +			dma-mask = <0xffffffff>;
> +			clocks = <&nand_clk>;

This belongs into the socfpga_arria10.dtsi.

Regards,
Steffen

-- 
Pengutronix e.K.                           | Steffen Trumtrar            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
