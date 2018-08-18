From: MNARANI@xilinx.com (Manish Narani)
Date: Sat, 18 Aug 2018 10:12:18 +0000
Subject: [PATCH v4 4/4] arm64: zynqmp: Add DDRC node
In-Reply-To: <1533374735-16662-5-git-send-email-manish.narani@xilinx.com>
References: <1533374735-16662-1-git-send-email-manish.narani@xilinx.com>
 <1533374735-16662-5-git-send-email-manish.narani@xilinx.com>
Message-ID: <DM6PR02MB52276B9FB674BC816BC28A82C13C0@DM6PR02MB5227.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping.

> -----Original Message-----
> From: Manish Narani [mailto:manish.narani at xilinx.com]
> Sent: Saturday, August 4, 2018 2:56 PM
> To: robh+dt at kernel.org; mark.rutland at arm.com; catalin.marinas at arm.com;
> will.deacon at arm.com; Michal Simek <michals@xilinx.com>; bp at alien8.de;
> mchehab at kernel.org; mdf at kernel.org; Edgar Iglesias <edgari@xilinx.com>;
> Shubhrajyoti Datta <shubhraj@xilinx.com>; Naga Sureshkumar Relli
> <nagasure@xilinx.com>; Bharat Kumar Gogada <bharatku@xilinx.com>;
> stefan.krsmanovic at aggios.com
> Cc: Srinivas Goud <sgoud@xilinx.com>; Anirudha Sarangi
> <anirudh@xilinx.com>; linux-kernel at vger.kernel.org;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> edac at vger.kernel.org; Manish Narani <MNARANI@xilinx.com>
> Subject: [PATCH v4 4/4] arm64: zynqmp: Add DDRC node
> 
> This patch adds ddrc memory controller node in dts. The size mentioned in dts
> is 0x30000, because we need to access DDR_QOS INTR registers located at
> fd090208 from this driver.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index a091e6f..7d6a3cf 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -355,6 +355,13 @@
>  			xlnx,bus-width = <64>;
>  		};
> 
> +		mc: memory-controller at fd070000 {
> +			compatible = "xlnx,zynqmp-ddrc-2.40a";
> +			reg = <0x0 0xfd070000 0x0 0x30000>;
> +			interrupt-parent = <&gic>;
> +			interrupts = <0 112 4>;
> +		};
> +
>  		gem0: ethernet at ff0b0000 {
>  			compatible = "cdns,zynqmp-gem", "cdns,gem";
>  			status = "disabled";
> --
> 2.1.1
