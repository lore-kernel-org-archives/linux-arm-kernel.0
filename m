From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 11 Sep 2014 12:16:39 -0400
Subject: [PATCH] ARM: keystone: dts: fix bindings for pcie and usb clock
 nodes
In-Reply-To: <1410450009-19892-1-git-send-email-m-karicheri2@ti.com>
References: <1410450009-19892-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <5411CAE7.9010108@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 11 September 2014 11:40 AM, Murali Karicheri wrote:
> Fix incorrect clock names for usb1, pcie1 and domain register
> offset for pcie1 clock nodes on K2E EVM
> 
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> ---
Thanks Murali. I will queue this up.

>  arch/arm/boot/dts/k2e-clocks.dtsi |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/k2e-clocks.dtsi b/arch/arm/boot/dts/k2e-clocks.dtsi
> index 598afe9..4773d6a 100644
> --- a/arch/arm/boot/dts/k2e-clocks.dtsi
> +++ b/arch/arm/boot/dts/k2e-clocks.dtsi
> @@ -40,7 +40,7 @@ clocks {
>  		#clock-cells = <0>;
>  		compatible = "ti,keystone,psc-clock";
>  		clocks = <&chipclk16>;
> -		clock-output-names = "usb";
> +		clock-output-names = "usb1";
>  		reg = <0x02350004 0xb00>, <0x02350000 0x400>;
>  		reg-names = "control", "domain";
>  		domain-id = <0>;
> @@ -60,8 +60,8 @@ clocks {
>  		#clock-cells = <0>;
>  		compatible = "ti,keystone,psc-clock";
>  		clocks = <&chipclk12>;
> -		clock-output-names = "pcie";
> -		reg = <0x0235006c 0xb00>, <0x02350000 0x400>;
> +		clock-output-names = "pcie1";
> +		reg = <0x0235006c 0xb00>, <0x02350048 0x400>;
>  		reg-names = "control", "domain";
>  		domain-id = <18>;
>  	};
> 
