From: karl.beldan@gmail.com (Karl Beldan)
Date: Thu, 29 Sep 2016 18:58:05 +0000
Subject: [PATCH 4/6] ARM: dts: da850-lcdk: add support for 1024x768
 resolution
In-Reply-To: <1475166715-7857-5-git-send-email-bgolaszewski@baylibre.com>
References: <1475166715-7857-1-git-send-email-bgolaszewski@baylibre.com>
 <1475166715-7857-5-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <20160929185805.q2pdihajikgzo4lm@gobelin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Sep 29, 2016 at 06:31:53PM +0200, Bartosz Golaszewski wrote:
> Add svga timings for 1024x768 resolution to the da850-lcdk
> device tree.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  arch/arm/boot/dts/da850-lcdk.dts | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
> index 6ca5d48..6e4288c 100644
> --- a/arch/arm/boot/dts/da850-lcdk.dts
> +++ b/arch/arm/boot/dts/da850-lcdk.dts
> @@ -70,8 +70,8 @@
>  		};
>  
>  		display-timings {
> -			native-mode = <&svga_timings>;
> -			svga_timings: 800x600 {
> +			native-mode = <&svga_timing0>;
> +			svga_timing0: 800x600 {
>  				clock-frequency = <37500000>;
>  				hactive = <800>;
>  				hback-porch = <140>;
> @@ -82,6 +82,17 @@
>  				vfront-porch = <1>;
>  				vsync-len = <4>;
>  			};
> +			svga_timing1: 1024x768 {
> +				clock-frequency = <72000000>;
> +				hactive = <1024>;
> +				hback-porch = <140>;
> +				hfront-porch = <40>;
> +				hsync-len = <128>;
> +				vactive = <768>;
> +				vback-porch = <23>;
> +				vfront-porch = <1>;
> +				vsync-len = <4>;
> +			};

Why do you also call 1024x768 svga ?

I don't think the LCDK can cope with this resolution at this frequency
(in terms of mem bandwidth), at least that's what I observed back in
August. If confirmed I think it is worth mentioning in the log at least,
but then I doubt adding this config would be useful.

Regards, 
Karl

>  		};
>  	};
>  };
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
