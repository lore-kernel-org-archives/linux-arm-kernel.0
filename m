From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 8 Jul 2014 12:19:52 -0400
Subject: [PATCH] ARM: dts: keystone: fix netcp's clocks definitions
In-Reply-To: <1404834184-5411-1-git-send-email-grygorii.strashko@ti.com>
References: <1404834184-5411-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <53BC1A28.3080608@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 08 July 2014 11:43 AM, Grygorii Strashko wrote:
> The clocks tree for Keystone 2 NTCP devices should be
> defined as following:
> [refclk] - board dependent
>  |- <papllclk> - PLL clock
>     |- <paclk13> - fixed factor clock div=3 mul=1
>        |- <clkpa> - gated clock
>        |- <clkcpgmac> - gated clock
>        |- <clksa> - gated clock
> 
> Hence, update Keystone 2 DT to follow HW specification.
> 
> Signed-off-by: WingMan Kwok <w-kwok2@ti.com>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
Thanks for the patch. Queuing it up for 3.17

>  arch/arm/boot/dts/k2e-clocks.dtsi      |    2 +-
>  arch/arm/boot/dts/k2hk-clocks.dtsi     |    2 +-
>  arch/arm/boot/dts/k2l-clocks.dtsi      |    2 +-
>  arch/arm/boot/dts/keystone-clocks.dtsi |    2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/k2e-clocks.dtsi b/arch/arm/boot/dts/k2e-clocks.dtsi
> index 90774d6..598afe9 100644
> --- a/arch/arm/boot/dts/k2e-clocks.dtsi
> +++ b/arch/arm/boot/dts/k2e-clocks.dtsi
> @@ -22,7 +22,7 @@ clocks {
>  		#clock-cells = <0>;
>  		compatible = "ti,keystone,pll-clock";
>  		clocks = <&refclkpass>;
> -		clock-output-names = "pa-pll-clk";
> +		clock-output-names = "papllclk";
>  		reg = <0x02620358 4>;
>  		reg-names = "control";
>  	};
> diff --git a/arch/arm/boot/dts/k2hk-clocks.dtsi b/arch/arm/boot/dts/k2hk-clocks.dtsi
> index 96e6536..d5adee3 100644
> --- a/arch/arm/boot/dts/k2hk-clocks.dtsi
> +++ b/arch/arm/boot/dts/k2hk-clocks.dtsi
> @@ -31,7 +31,7 @@ clocks {
>  		#clock-cells = <0>;
>  		compatible = "ti,keystone,pll-clock";
>  		clocks = <&refclkpass>;
> -		clock-output-names = "pa-pll-clk";
> +		clock-output-names = "papllclk";
>  		reg = <0x02620358 4>;
>  		reg-names = "control";
>  	};
> diff --git a/arch/arm/boot/dts/k2l-clocks.dtsi b/arch/arm/boot/dts/k2l-clocks.dtsi
> index f584b80..eb1e3e2 100644
> --- a/arch/arm/boot/dts/k2l-clocks.dtsi
> +++ b/arch/arm/boot/dts/k2l-clocks.dtsi
> @@ -31,7 +31,7 @@ clocks {
>  		#clock-cells = <0>;
>  		compatible = "ti,keystone,pll-clock";
>  		clocks = <&refclksys>;
> -		clock-output-names = "pa-pll-clk";
> +		clock-output-names = "papllclk";
>  		reg = <0x02620358 4>;
>  		reg-names = "control";
>  	};
> diff --git a/arch/arm/boot/dts/keystone-clocks.dtsi b/arch/arm/boot/dts/keystone-clocks.dtsi
> index 93f82c7..0c334b2 100644
> --- a/arch/arm/boot/dts/keystone-clocks.dtsi
> +++ b/arch/arm/boot/dts/keystone-clocks.dtsi
> @@ -215,7 +215,7 @@ clocks {
>  	clkpa: clkpa {
>  		#clock-cells = <0>;
>  		compatible = "ti,keystone,psc-clock";
> -		clocks = <&chipclk16>;
> +		clocks = <&paclk13>;
>  		clock-output-names = "pa";
>  		reg = <0x0235001c 0xb00>, <0x02350008 0x400>;
>  		reg-names = "control", "domain";
> 
