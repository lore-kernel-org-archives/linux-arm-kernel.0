From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 23 Jul 2015 12:55:55 +0100
Subject: [PATCH 1/2] devicetree: bindings: rtc: add bindings for xilinx
 zynqmp rtc
In-Reply-To: <1437648710-6857-1-git-send-email-suneel.garapati@xilinx.com>
References: <1437648710-6857-1-git-send-email-suneel.garapati@xilinx.com>
Message-ID: <20150723115555.GC12330@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 23, 2015 at 11:51:49AM +0100, Suneel Garapati wrote:
> adds file for description on device node bindings for RTC
> found on Xilinx Zynq Ultrascale+ MPSoC.
> 
> Signed-off-by: Suneel Garapati <suneel.garapati@xilinx.com>
> ---
>  Documentation/devicetree/bindings/rtc/xlnx-rtc.txt | 25 ++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/xlnx-rtc.txt
> 
> diff --git a/Documentation/devicetree/bindings/rtc/xlnx-rtc.txt b/Documentation/devicetree/bindings/rtc/xlnx-rtc.txt
> new file mode 100644
> index 0000000..2b05243
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/xlnx-rtc.txt
> @@ -0,0 +1,25 @@
> +* Xilinx Zynq Ultrascale+ MPSoC Real Time Clock
> +
> +RTC controller for the Xilinx Zynq MPSoC Real Time Clock
> +Separate IRQ lines for seconds and alarm
> +
> +Required properties:
> +- compatible: Should be "xlnx,zynqmp-rtc"
> +- reg: Physical base address of the controller and length
> +       of memory mapped region.
> +- interrupts: IRQ lines for the RTC.
> +- interrupt names: Names for interrupt lines

interrupt-names has a '-', and you need to state which names are
expected.

> +
> +Optional:
> +- calibration: calibration value for 1 sec period which will
> +		be programmed directly to calibration register

When and why would I set this?

Mark.

> +
> +Example:
> +rtc: rtc at ffa60000 {
> +	compatible = "xlnx,zynqmp-rtc";
> +	reg = <0x0 0xffa60000 0x100>;
> +	interrupt-parent = <&gic>;
> +	interrupts = <0 26 4>, <0 27 4>;
> +	interrupt-names = "alm", "sec";
> +	calibration = <0x198233>;
> +};
> --
> 2.1.2
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
