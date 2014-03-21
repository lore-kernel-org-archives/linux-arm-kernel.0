From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 21 Mar 2014 22:33:34 +0100
Subject: [PATCH v2 3/5] ARM: berlin/dt: add cpupll and syspll support
 to BG2Q
In-Reply-To: <1395432521-11055-4-git-send-email-alexandre.belloni@free-electrons.com>
References: <1395432521-11055-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1395432521-11055-4-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <532CB02E.90209@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/21/2014 09:08 PM, Alexandre Belloni wrote:
> The Berlin BG2Q has two supported PLLs: CPU PLL and System PLL, add those to the
> SoC device tree.
>
> Note that support for the AVPLL is not yet available.

Above should not be part of the commit message, no need to resend.
I can fix it up.

Sebastian

> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>   arch/arm/boot/dts/berlin2q.dtsi | 22 +++++++++++++++-------
>   1 file changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
> index 07452a7483fa..5925e6a16749 100644
> --- a/arch/arm/boot/dts/berlin2q.dtsi
> +++ b/arch/arm/boot/dts/berlin2q.dtsi
> @@ -59,16 +59,10 @@
>   		clock-frequency = <100000000>;
>   	};
>
> -	cpuclk: cpu-clock {
> -		compatible = "fixed-clock";
> -		#clock-cells = <0>;
> -		clock-frequency = <1200000000>;
> -	};
> -
>   	twdclk: twdclk {
>   		compatible = "fixed-factor-clock";
>   		#clock-cells = <0>;
> -		clocks = <&cpuclk>;
> +		clocks = <&cpupll>;
>   		clock-mult = <1>;
>   		clock-div = <3>;
>   	};
> @@ -101,6 +95,20 @@
>   			#interrupt-cells = <3>;
>   		};
>
> +		cpupll: cpupll at dd0170 {
> +			compatible = "marvell,berlin2q-pll";
> +			clocks = <&smclk>;
> +			#clock-cells = <0>;
> +			reg = <0xdd0170 0x8>;
> +		};
> +
> +		syspll: syspll at ea0030 {
> +			compatible = "marvell,berlin2q-pll";
> +			clocks = <&smclk>;
> +			#clock-cells = <0>;
> +			reg = <0xea0030 0x8>;
> +		};
> +
>   		apb at e80000 {
>   			compatible = "simple-bus";
>   			#address-cells = <1>;
>
