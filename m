From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 07 Mar 2017 17:38:18 +0100
Subject: [PATCH] ARM: DTS armada: Add default trigger for sata led
In-Reply-To: <1488287750-28626-1-git-send-email-ansuelsmth@gmail.com> (Ansuel
 Smith's message of "Tue, 28 Feb 2017 14:15:50 +0100")
References: <1488287750-28626-1-git-send-email-ansuelsmth@gmail.com>
Message-ID: <87fuipoxdx.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ansuel,
 
 On mar., f?vr. 28 2017, Ansuel Smith <ansuelsmth@gmail.com> wrote:

> In others board we have the sata led set to funcion
> with the sata led trigger by default.
> This patch makes the same for these board that have sata
> led but get disabled by not associating it to any trigger.
>
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>

Applied on mvebu/dt (I also fixed the typo on func_t_ion and added the
acked-by from Jason)

Thanks,

Gregory

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

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
