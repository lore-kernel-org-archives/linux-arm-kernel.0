From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 16 Apr 2013 16:54:01 +0200
Subject: [PATCH 8/8] ARM: at91: sam9263ek: add dt lcd support
In-Reply-To: <1365692422-9565-8-git-send-email-plagnioj@jcrosoft.com>
References: <20130411145741.GB25242@game.jcrosoft.org>
 <1365692422-9565-1-git-send-email-plagnioj@jcrosoft.com>
 <1365692422-9565-8-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <516D6609.5020706@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/2013 05:00 PM, Jean-Christophe PLAGNIOL-VILLARD :
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  arch/arm/boot/dts/at91sam9263ek.dts |   30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/at91sam9263ek.dts b/arch/arm/boot/dts/at91sam9263ek.dts
> index 1eb0872..d471b49 100644
> --- a/arch/arm/boot/dts/at91sam9263ek.dts
> +++ b/arch/arm/boot/dts/at91sam9263ek.dts
> @@ -81,6 +81,36 @@
>  			};
>  		};
>  
> +		fb0: fb at 0x00500000 {

Ditto: Not good address: 0x700000

> +			display = <&display0>;
> +			status = "okay";
> +
> +			display0: display {
> +				bits-per-pixel = <16>;
> +				atmel,lcdcon-backlight;
> +				atmel,dmacon = <0x1>;
> +				atmel,lcdcon2 = <0x80008002>;
> +				atmel,guard-time = <1>;
> +
> +				display-timings {
> +					native-mode = <&timing0>;
> +					timing0: timing0 {
> +						clock-frequency = <4965000>;
> +						hactive = <240>;
> +						vactive = <320>;
> +						hback-porch = <1>;
> +						hfront-porch = <33>;
> +						vback-porch = <1>;
> +						vfront-porch = <0>;
> +						hsync-len = <5>;
> +						vsync-len = <1>;
> +						hsync-active = <1>;
> +						vsync-active = <1>;
> +					};
> +				};
> +			};
> +		};

Otherwise, seems good.

> +
>  		nand0: nand at 40000000 {
>  			nand-bus-width = <8>;
>  			nand-ecc-mode = "soft";
> 


-- 
Nicolas Ferre
