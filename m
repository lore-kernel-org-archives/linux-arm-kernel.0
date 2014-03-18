From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 18 Mar 2014 12:09:22 -0400
Subject: [PATCH] ARM: dts: keystone: Fix domain register range for clkfftc1
In-Reply-To: <1395148697-22481-1-git-send-email-ivan.khoronzhuk@ti.com>
References: <1395148697-22481-1-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <53286FB2.1040903@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 March 2014 09:18 AM, Ivan Khoronzhuk wrote:
> The domain register range for clkfftc1 has to be 0x0235004c
> instead of 0x023504c0.
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
> ---
Thanks .. Applying for 3.15-fixes

>  arch/arm/boot/dts/k2hk-clocks.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/k2hk-clocks.dtsi b/arch/arm/boot/dts/k2hk-clocks.dtsi
> index 8855b1f..96e6536 100644
> --- a/arch/arm/boot/dts/k2hk-clocks.dtsi
> +++ b/arch/arm/boot/dts/k2hk-clocks.dtsi
> @@ -209,7 +209,7 @@ clocks {
>  		compatible = "ti,keystone,psc-clock";
>  		clocks = <&chipclk13>;
>  		clock-output-names = "fftc-1";
> -		reg = <0x02350074 0xb00>, <0x023504c0 0x400>;
> +		reg = <0x02350074 0xb00>, <0x0235004c 0x400>;
>  		reg-names = "control", "domain";
>  		domain-id = <19>;
>  	};
> 
