From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 18 Mar 2014 12:09:35 -0400
Subject: [PATCH] ARM: dts: keystone: Fix control register range for clktsip
In-Reply-To: <1395148991-22538-1-git-send-email-ivan.khoronzhuk@ti.com>
References: <1395148991-22538-1-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <53286FBF.6050708@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 March 2014 09:23 AM, Ivan Khoronzhuk wrote:
> The control register range for clktsio interferes with clkaemifspi clock.
> And it causes issues for NAND/AEMIF. So fix it.
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
> ---
> 
> Only comment is corrected.
> 
Thanks .. Applying for 3.15-fixes

>  arch/arm/boot/dts/k2hk-clocks.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/k2hk-clocks.dtsi b/arch/arm/boot/dts/k2hk-clocks.dtsi
> index a71aa29..8855b1f 100644
> --- a/arch/arm/boot/dts/k2hk-clocks.dtsi
> +++ b/arch/arm/boot/dts/k2hk-clocks.dtsi
> @@ -59,7 +59,7 @@ clocks {
>  		compatible = "ti,keystone,psc-clock";
>  		clocks = <&chipclk16>;
>  		clock-output-names = "tsip";
> -		reg = <0x0235000c 0xb00>, <0x02350000 0x400>;
> +		reg = <0x02350000 0xb00>, <0x02350000 0x400>;
>  		reg-names = "control", "domain";
>  		domain-id = <0>;
>  	};
> 
