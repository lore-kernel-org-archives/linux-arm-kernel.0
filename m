From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 9 Oct 2013 15:14:28 +0200
Subject: [PATCH 6/6] ARM: at91/dt: remove old main clk definition from
 sama5d3xcm.dtsi
In-Reply-To: <1375957837-11600-1-git-send-email-b.brezillon@overkiz.com>
References: <1375951572-10829-1-git-send-email-b.brezillon@overkiz.com>
 <1375957837-11600-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <525556B4.4020809@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08/2013 12:30, Boris BREZILLON :
> This patch removes the old main clk node which is now useless as sama5d3
> SoCs and boards are no longer compatible with the old at91 clk
> implementations.
>
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>

As said earlier, removal of old clock definitions is needed in this 
patch. You can even squash all this cleanup stuff in a single patch to 
remove all old material.

otherwise:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>   arch/arm/boot/dts/sama5d3xcm.dtsi |   11 -----------
>   1 file changed, 11 deletions(-)
>
> diff --git a/arch/arm/boot/dts/sama5d3xcm.dtsi b/arch/arm/boot/dts/sama5d3xcm.dtsi
> index f19d5bf..81c3957 100644
> --- a/arch/arm/boot/dts/sama5d3xcm.dtsi
> +++ b/arch/arm/boot/dts/sama5d3xcm.dtsi
> @@ -18,17 +18,6 @@
>   		reg = <0x20000000 0x20000000>;
>   	};
>
> -	clocks {
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		ranges;
> -
> -		main_clock: clock at 0 {
> -			compatible = "atmel,osc", "fixed-clock";
> -			clock-frequency = <12000000>;
> -		};
> -	};
> -
>   	ahb {
>   		apb {
>   			spi0: spi at f0004000 {
>


-- 
Nicolas Ferre
