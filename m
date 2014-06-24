From: fcooper@ti.com (Cooper Jr., Franklin)
Date: Tue, 24 Jun 2014 18:39:40 +0000
Subject: [PATCH v3 1/2] arm: dts: am4372: let boards access all nodes
 through phandles
In-Reply-To: <1403547659-24558-2-git-send-email-balbi@ti.com>
References: <1403547659-24558-1-git-send-email-balbi@ti.com>
 <1403547659-24558-2-git-send-email-balbi@ti.com>
Message-ID: <8F29D6B095ED194EA1980491A5E029710C6D71A1@DFLE08.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tested-by: Franklin Cooper Jr. <fcooper@ti.com>

> -----Original Message-----
> From: Balbi, Felipe
> Sent: Monday, June 23, 2014 1:21 PM
> To: Benoit Cousson
> Cc: robh+dt at kernel.org; galak at codeaurora.org; Tony Lindgren;
> linux at arm.linux.org.uk; Nayak, Rajendra; Menon, Nishanth; R, Sricharan;
> devicetree at vger.kernel.org; Linux Kernel Mailing List; Linux OMAP Mailing
> List; Linux ARM Kernel Mailing List; Balbi, Felipe
> Subject: [PATCH v3 1/2] arm: dts: am4372: let boards access all nodes through
> phandles
> 
> by providing phandles to rtc, wdt, cpu and dispc nodes, boards can access
> them to add board-specific data.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
> 
> Changes since v1:
> 	- added phandles to cpu and dispc
> 
>  arch/arm/boot/dts/am4372.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
> index 49fa596..8d3c163 100644
> --- a/arch/arm/boot/dts/am4372.dtsi
> +++ b/arch/arm/boot/dts/am4372.dtsi
> @@ -30,7 +30,7 @@
>  	cpus {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> -		cpu at 0 {
> +		cpu: cpu at 0 {
>  			compatible = "arm,cortex-a9";
>  			device_type = "cpu";
>  			reg = <0>;
> @@ -270,7 +270,7 @@
>  			ti,hwmods = "counter_32k";
>  		};
> 
> -		rtc at 44e3e000 {
> +		rtc: rtc at 44e3e000 {
>  			compatible = "ti,am4372-rtc","ti,da830-rtc";
>  			reg = <0x44e3e000 0x1000>;
>  			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH @@ -
> 279,7 +279,7 @@
>  			status = "disabled";
>  		};
> 
> -		wdt at 44e35000 {
> +		wdt: wdt at 44e35000 {
>  			compatible = "ti,am4372-wdt","ti,omap3-wdt";
>  			reg = <0x44e35000 0x1000>;
>  			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>; @@
> -871,7 +871,7 @@
>  			#size-cells = <1>;
>  			ranges;
> 
> -			dispc at 4832a400 {
> +			dispc: dispc at 4832a400 {
>  				compatible = "ti,omap3-dispc";
>  				reg = <0x4832a400 0x400>;
>  				interrupts = <GIC_SPI 127
> IRQ_TYPE_LEVEL_HIGH>;
> --
> 2.0.0.390.gcb682f8
