From: edubezval@gmail.com (Eduardo Valentin)
Date: Fri, 27 Feb 2015 17:35:37 -0400
Subject: [PATCH] ARM: dts: OMAP5: fix polling intervals for thermal zones
In-Reply-To: <1425045543-19540-1-git-send-email-t-kristo@ti.com>
References: <1425045543-19540-1-git-send-email-t-kristo@ti.com>
Message-ID: <20150227213535.GA5633@developer.amazonguestwifi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 27, 2015 at 03:59:03PM +0200, Tero Kristo wrote:
> OMAP4 has a finer counter granularity, which allows for a delay of 1000ms
> in the thermal zone polling intervals. OMAP5 has a different counter
> mechanism, which allows at maximum a 500ms timer. Adjust the cpu thermal
> zone polling interval accordingly.
> 
> Without this patch, the polling interval information is simply ignored,
> and the following thermal warnings are printed during boot (assuming
> thermal is enabled);
> 
> [    1.545343] ti-soc-thermal 4a0021e0.bandgap: Delay 1000 ms is not supported
> [    1.552691] ti-soc-thermal 4a0021e0.bandgap: Delay 1000 ms is not supported
> [    1.560029] ti-soc-thermal 4a0021e0.bandgap: Delay 1000 ms is not supported
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>

Acked-by: Eduardo Valentin <edubezval@gmail.com>


> ---
>  arch/arm/boot/dts/omap5-core-thermal.dtsi |    2 +-
>  arch/arm/boot/dts/omap5-gpu-thermal.dtsi  |    2 +-
>  arch/arm/boot/dts/omap5.dtsi              |    4 ++++
>  3 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap5-core-thermal.dtsi b/arch/arm/boot/dts/omap5-core-thermal.dtsi
> index 19212ac..de8a3d4 100644
> --- a/arch/arm/boot/dts/omap5-core-thermal.dtsi
> +++ b/arch/arm/boot/dts/omap5-core-thermal.dtsi
> @@ -13,7 +13,7 @@
>  
>  core_thermal: core_thermal {
>  	polling-delay-passive = <250>; /* milliseconds */
> -	polling-delay = <1000>; /* milliseconds */
> +	polling-delay = <500>; /* milliseconds */
>  
>  			/* sensor       ID */
>  	thermal-sensors = <&bandgap     2>;
> diff --git a/arch/arm/boot/dts/omap5-gpu-thermal.dtsi b/arch/arm/boot/dts/omap5-gpu-thermal.dtsi
> index 1b87aca..bc3090f 100644
> --- a/arch/arm/boot/dts/omap5-gpu-thermal.dtsi
> +++ b/arch/arm/boot/dts/omap5-gpu-thermal.dtsi
> @@ -13,7 +13,7 @@
>  
>  gpu_thermal: gpu_thermal {
>  	polling-delay-passive = <250>; /* milliseconds */
> -	polling-delay = <1000>; /* milliseconds */
> +	polling-delay = <500>; /* milliseconds */
>  
>  			/* sensor       ID */
>  	thermal-sensors = <&bandgap     1>;
> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index b321fdf..fee1580 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -1079,4 +1079,8 @@
>  	};
>  };
>  
> +&cpu_thermal {
> +	polling-delay = <500>; /* milliseconds */
> +};
> +
>  /include/ "omap54xx-clocks.dtsi"
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150227/f7f0af19/attachment.sig>
