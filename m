From: thomas.petazzoni@bootlin.com (Thomas Petazzoni)
Date: Wed, 27 Jun 2018 17:16:27 +0200
Subject: [PATCH v3 2/2] ARM: dts: pxa: fix the rtc controller
In-Reply-To: <20180627150150.23951-2-robert.jarzmik@free.fr>
References: <20180627150150.23951-1-robert.jarzmik@free.fr>
 <20180627150150.23951-2-robert.jarzmik@free.fr>
Message-ID: <20180627171627.592849b5@windsurf.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, 27 Jun 2018 17:01:50 +0200, Robert Jarzmik wrote:
> The RTC controller is fed by an external fixed 32kHz clock. Yet the
> driver wants to acquire this clock, even though it doesn't make any use
> of it, ie. doesn't get the rate to make calculation.
> 
> Therefore, use the exported 32.768kHz clock in the PXA clock tree to
> make the driver happy and working.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
> Since v1: change the dummy clock by the actual 32.768kHz
> ---
>  arch/arm/boot/dts/pxa25x.dtsi | 4 ++++
>  arch/arm/boot/dts/pxa27x.dtsi | 4 ++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/pxa25x.dtsi b/arch/arm/boot/dts/pxa25x.dtsi
> index 95d59be97213..78a413ea0e88 100644
> --- a/arch/arm/boot/dts/pxa25x.dtsi
> +++ b/arch/arm/boot/dts/pxa25x.dtsi
> @@ -80,6 +80,10 @@
>  			#pwm-cells = <1>;
>  			clocks = <&clks CLK_PWM1>;
>  		};
> +
> +		rtc at 40900000 {
> +			clocks = <&clks CLK_OSC32k768>>;

Double closing bracket, doesn't look good.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
