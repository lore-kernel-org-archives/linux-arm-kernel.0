From: michal.simek@xilinx.com (Michal Simek)
Date: Tue, 4 Aug 2015 10:13:50 +0200
Subject: [RFCv3 2/4] dts: zynq: Add devicetree entry for Xilinx Zynq reset
 controller.
In-Reply-To: <1438305237-18497-3-git-send-email-moritz.fischer@ettus.com>
References: <1438305237-18497-1-git-send-email-moritz.fischer@ettus.com>
 <1438305237-18497-3-git-send-email-moritz.fischer@ettus.com>
Message-ID: <55C0743E.1090406@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/31/2015 03:13 AM, Moritz Fischer wrote:
> Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
> ---
>  arch/arm/boot/dts/zynq-7000.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
> index 0691508..6bebf02 100644
> --- a/arch/arm/boot/dts/zynq-7000.dtsi
> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
> @@ -1,5 +1,6 @@
>  /*
>   *  Copyright (C) 2011 - 2014 Xilinx
> + *  Copyright (C) 2015 National Instruments Corp.
>   *
>   * This software is licensed under the terms of the GNU General Public
>   * License version 2, as published by the Free Software Foundation, and
> @@ -258,6 +259,13 @@
>  				reg = <0x100 0x100>;
>  			};
>  
> +			rstc: rstc at 200 {
> +				compatible = "xlnx,zynq-reset";
> +				reg = <0x200 0x48>;
> +				#reset-cells = <1>;
> +				syscon = <&slcr>;
> +			};
> +
>  			pinctrl0: pinctrl at 700 {
>  				compatible = "xlnx,pinctrl-zynq";
>  				reg = <0x700 0x200>;
> 

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
