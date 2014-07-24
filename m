From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Thu, 24 Jul 2014 16:18:29 -0700
Subject: [PATCH v2 05/11] ARM: dts: zynq: Add QSPI for Parallella
In-Reply-To: <1406242820-20140-6-git-send-email-afaerber@suse.de>
References: <1406242820-20140-1-git-send-email-afaerber@suse.de>
 <1406242820-20140-6-git-send-email-afaerber@suse.de>
Message-ID: <ddb38ce5-9e31-4c94-967c-7784c7fba75c@BN1BFFO11FD028.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-07-25 at 01:00AM +0200, Andreas F?rber wrote:
> Prepare SPI0 and SPI1 while at it.
> 
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v2: New
>  
>  arch/arm/boot/dts/zynq-7000.dtsi      | 37 +++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/zynq-parallella.dts |  4 ++++
>  2 files changed, 41 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
> index 8fd826a..eed3df0 100644
> --- a/arch/arm/boot/dts/zynq-7000.dtsi
> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
> @@ -122,6 +122,30 @@
>  			interrupts = <0 50 4>;
>  		};
>  
> +		spi0: spi at e0006000 {
> +			compatible = "xlnx,zynq-spi-r1p6";
> +			reg = <0xe0006000 0x1000>;
> +			status = "disabled";
> +			interrupt-parent = <&intc>;
> +			interrupts = <0 26 4>;
> +			clocks = <&clkc 25>, <&clkc 34>;
> +			clock-names = "ref_clk", "pclk";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		spi1: spi at e0007000 {
> +			compatible = "xlnx,zynq-spi-r1p6";
> +			reg = <0xe0007000 0x1000>;
> +			status = "disabled";
> +			interrupt-parent = <&intc>;
> +			interrupts = <0 49 4>;
> +			clocks = <&clkc 26>, <&clkc 35>;
> +			clock-names = "ref_clk", "pclk";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
Until here things look good.

>  		gem0: ethernet at e000b000 {
>  			compatible = "cdns,gem";
>  			reg = <0xe000b000 0x4000>;
> @@ -140,6 +164,19 @@
>  			clock-names = "pclk", "hclk", "tx_clk";
>  		};
>  
> +		qspi: qspi at e000d000 {
> +			compatible = "xlnx,zynq-spi-r1p6";
> +			reg = <0xe000d000 0x1000>;
> +			status = "disabled";
> +			interrupt-parent = <&intc>;
> +			interrupts = <0 19 4>;
> +			clocks = <&clkc 10>, <&clkc 43>;
> +			clock-names = "ref_clk", "pclk";
> +			num-cs = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
I'm not sure what the status of this driver is. I think QSPI is still
under review on the mailing lists and I don't think we should add this
yet.

	S?ren
