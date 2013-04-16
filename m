From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 16 Apr 2013 16:56:43 +0200
Subject: [PATCH 7/8] ARM: at91: at9sam9m10g45ek: add dt lcd support
In-Reply-To: <1365692422-9565-7-git-send-email-plagnioj@jcrosoft.com>
References: <20130411145741.GB25242@game.jcrosoft.org>
 <1365692422-9565-1-git-send-email-plagnioj@jcrosoft.com>
 <1365692422-9565-7-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <516D66AB.7050804@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/2013 05:00 PM, Jean-Christophe PLAGNIOL-VILLARD :
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  arch/arm/boot/dts/at91sam9m10g45ek.dts |   29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
> index 20c3191..79dc034 100644
> --- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
> +++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
> @@ -104,6 +104,35 @@
>  			};
>  		};
>  
> +		fb0: fb at 0x00500000 {
> +			display = <&display0>;
> +			status = "okay";
> +
> +			display0: display {
> +				bits-per-pixel = <32>;
> +				atmel,lcdcon-backlight;
> +				atmel,dmacon = <0x1>;
> +				atmel,lcdcon2 = <0x80008002>;
> +				atmel,guard-time = <9>;
> +				atmel,lcd-wiring-mode = "RGB";
> +
> +				display-timings {
> +					native-mode = <&timing0>;
> +					timing0: timing0 {
> +						clock-frequency = <9000000>;
> +						hactive = <480>;
> +						vactive = <272>;
> +						hback-porch = <1>;
> +						hfront-porch = <1>;
> +						vback-porch = <40>;
> +						vfront-porch = <1>;
> +						hsync-len = <45>;
> +						vsync-len = <1>;
> +					};
> +				};
> +			};
> +		};
> +

Seems good.

>  		nand0: nand at 40000000 {
>  			nand-bus-width = <8>;
>  			nand-ecc-mode = "soft";
> 


-- 
Nicolas Ferre
