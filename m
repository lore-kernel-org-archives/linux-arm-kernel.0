From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 18 Feb 2017 14:12:13 +0000
Subject: [PATCH] DTS: Linksys Board: Add default trigger for sata led
In-Reply-To: <1487364137-3008-1-git-send-email-ansuelsmth@gmail.com>
References: <1487364137-3008-1-git-send-email-ansuelsmth@gmail.com>
Message-ID: <20170218141213.GK25924@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ansuel,

On Fri, Feb 17, 2017 at 09:42:17PM +0100, Ansuel Smith wrote:
> In others board we have the sata led set to funcion with the sata led trigger by default.
> This patch makes the same for these board that have sata led but disabled by not associating it to any trigger

Please line wrap the commit message.  Other than that,

> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.

> ---
>  arch/arm/boot/dts/armada-385-linksys-caiman.dts | 1 +
>  arch/arm/boot/dts/armada-385-linksys-cobra.dts  | 1 +
>  arch/arm/boot/dts/armada-xp-linksys-mamba.dts   | 1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/armada-385-linksys-caiman.dts b/arch/arm/boot/dts/armada-385-linksys-caiman.dts
> index f3cee91..a1b6e68 100644
> --- a/arch/arm/boot/dts/armada-385-linksys-caiman.dts
> +++ b/arch/arm/boot/dts/armada-385-linksys-caiman.dts
> @@ -109,6 +109,7 @@
>  
>  		sata {
>  			label = "caiman:white:sata";
> +			linux,default-trigger = "disk-activity";
>  		};
>  	};
>  };
> diff --git a/arch/arm/boot/dts/armada-385-linksys-cobra.dts b/arch/arm/boot/dts/armada-385-linksys-cobra.dts
> index 1110718..a1a75af 100644
> --- a/arch/arm/boot/dts/armada-385-linksys-cobra.dts
> +++ b/arch/arm/boot/dts/armada-385-linksys-cobra.dts
> @@ -109,6 +109,7 @@
>  
>  		sata {
>  			label = "cobra:white:sata";
> +			linux,default-trigger = "disk-activity";
>  		};
>  	};
>  };
> diff --git a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
> index 83ac884..dcd73ab 100644
> --- a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
> +++ b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
> @@ -156,6 +156,7 @@
>  					esata at 4 {
>  						label = "mamba:white:esata";
>  						reg = <0x4>;
> +						linux,default-trigger = "disk-activity";
>  					};
>  
>  					usb2 at 5 {
> -- 
> 1.9.1
> 
