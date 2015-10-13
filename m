From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Tue, 13 Oct 2015 20:57:50 +0200
Subject: [PATCH] ARM: socfpga: dts: add fpga manager
In-Reply-To: <1444760900-1373-1-git-send-email-atull@opensource.altera.com>
References: <1444760900-1373-1-git-send-email-atull@opensource.altera.com>
Message-ID: <20151013185750.GB17155@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alan!

On Tue, Oct 13, 2015 at 01:28:20PM -0500, atull at opensource.altera.com wrote:
> From: Alan Tull <atull@opensource.altera.com>
> 
> Add FPGA manager to device tree for SoCFPGA.
> 
> Signed-off-by: Alan Tull <atull@opensource.altera.com>
> ---
>  arch/arm/boot/dts/socfpga.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> index 314e589..e37ba11 100644
> --- a/arch/arm/boot/dts/socfpga.dtsi
> +++ b/arch/arm/boot/dts/socfpga.dtsi
> @@ -834,5 +834,12 @@
>  			compatible = "altr,sys-mgr", "syscon";
>  			reg = <0xffd08000 0x4000>;
>  		};
> +
> +		hps_0_fpgamgr: fpgamgr at 0xff706000 {
> +			compatible = "altr,socfpga-fpga-mgr";
> +			reg = <0xFF706000 0x1000
> +			       0xFFB90000 0x1000>;
> +			interrupts = <0 175 4>;
> +		};
>  	};
>  };

Please keep the format in line with the rest of the file:
Hexvalues are lowercase and no 0x after the "fpgamgr@".
I'd say "And please put the node in its proper position
according to its address", but I see just now, that the
dtsi is all messed up right now anyway :-(

Regards,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
