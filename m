From: dinguyen@altera.com (Dinh Nguyen)
Date: Fri, 23 Aug 2013 18:39:36 -0500
Subject: [PATCHv4 1/4] arm: dts: Add clock entries for timers in SOCFPGA
In-Reply-To: <1377189026-16656-1-git-send-email-dinguyen@altera.com>
References: <1377189026-16656-1-git-send-email-dinguyen@altera.com>
Message-ID: <1377301176.7061.2.camel@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Thu, 2013-08-22 at 11:30 -0500, Dinh Nguyen wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Set the correct clock entries for the the timers, and also clean up
> the timer entries for SOCFPGA by removing timer<n> in the timer entry.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> Reviewed-by: Pavel Machek <pavel@denx.de>
> CC: Rob Herring <rob.herring@calxeda.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Ian Campbell <ian.campbell@citrix.com>
> CC: Arnd Bergmann <arnd@arndb.de>
> Cc: Olof Johansson <olof@lixom.net>
> CC: Jamie Iles <jamie@jamieiles.com>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Pavel Machek <pavel@denx.de>
> Cc: devicetree at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  arch/arm/boot/dts/socfpga.dtsi         |   16 ++++++++--------
>  arch/arm/boot/dts/socfpga_cyclone5.dts |    8 ++++----
>  arch/arm/boot/dts/socfpga_vt.dts       |    8 ++++----
>  3 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> index bee62a2..2cb5cb7 100644
> --- a/arch/arm/boot/dts/socfpga.dtsi
> +++ b/arch/arm/boot/dts/socfpga.dtsi
> @@ -26,10 +26,6 @@
>  		ethernet1 = &gmac1;
>  		serial0 = &uart0;
>  		serial1 = &uart1;
> -		timer0 = &timer0;
> -		timer1 = &timer1;
> -		timer2 = &timer2;
> -		timer3 = &timer3;
>  	};
>  
>  	cpus {
> @@ -475,28 +471,32 @@
>  			interrupts = <1 13 0xf04>;
>  		};
>  
> -		timer0: timer0 at ffc08000 {
> +		timer at ffc08000 {
>  			compatible = "snps,dw-apb-timer-sp";
>  			interrupts = <0 167 4>;
>  			reg = <0xffc08000 0x1000>;
> +			clocks = <&osc>;
>  		};
>  
> -		timer1: timer1 at ffc09000 {
> +		timer at ffc09000 {
>  			compatible = "snps,dw-apb-timer-sp";
>  			interrupts = <0 168 4>;
>  			reg = <0xffc09000 0x1000>;
> +			clocks = <&osc>;
>  		};
>  
> -		timer2: timer2 at ffd00000 {
> +		timer at ffd00000 {
>  			compatible = "snps,dw-apb-timer-osc";
>  			interrupts = <0 169 4>;
>  			reg = <0xffd00000 0x1000>;
> +			clocks = <&l4_sp_clk>;
>  		};
>  
> -		timer3: timer3 at ffd01000 {
> +		timer at ffd01000 {
>  			compatible = "snps,dw-apb-timer-osc";
>  			interrupts = <0 170 4>;
>  			reg = <0xffd01000 0x1000>;
> +			clocks = <&l4_sp_clk>;
>  		};
>  
>  		uart0: serial0 at ffc02000 {
> diff --git a/arch/arm/boot/dts/socfpga_cyclone5.dts b/arch/arm/boot/dts/socfpga_cyclone5.dts
> index 973999d..8978790 100644
> --- a/arch/arm/boot/dts/socfpga_cyclone5.dts
> +++ b/arch/arm/boot/dts/socfpga_cyclone5.dts
> @@ -54,19 +54,19 @@
>  			status = "okay";
>  		};
>  
> -		timer0 at ffc08000 {
> +		timer at ffc08000 {
>  			clock-frequency = <100000000>;
>  		};
>  
> -		timer1 at ffc09000 {
> +		timer at ffc09000 {
>  			clock-frequency = <100000000>;
>  		};
>  
> -		timer2 at ffd00000 {
> +		timer at ffd00000 {
>  			clock-frequency = <25000000>;
>  		};
>  
> -		timer3 at ffd01000 {
> +		timer at ffd01000 {
>  			clock-frequency = <25000000>;
>  		};
>  
> diff --git a/arch/arm/boot/dts/socfpga_vt.dts b/arch/arm/boot/dts/socfpga_vt.dts
> index d1ec0ca..679320f 100644
> --- a/arch/arm/boot/dts/socfpga_vt.dts
> +++ b/arch/arm/boot/dts/socfpga_vt.dts
> @@ -46,19 +46,19 @@
>  			status = "okay";
>  		};
>  
> -		timer0 at ffc08000 {
> +		timer at ffc08000 {
>  			clock-frequency = <7000000>;
>  		};
>  
> -		timer1 at ffc09000 {
> +		timer at ffc09000 {
>  			clock-frequency = <7000000>;
>  		};
>  
> -		timer2 at ffd00000 {
> +		timer at ffd00000 {
>  			clock-frequency = <7000000>;
>  		};
>  
> -		timer3 at ffd01000 {
> +		timer at ffd01000 {
>  			clock-frequency = <7000000>;
>  		};
>  

Not sure if you our Ack for:
[
PATCHv4 2/4] arm: dts: Change dw-apb-timer-osc and dw-apb-timer-sp to
just dw-apb-timer

applies to this one too. But just in case, can I get your Ack for this
one too?

Thanks,
Dinh
