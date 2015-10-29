From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 29 Oct 2015 09:56:59 +0100
Subject: [PATCH 19/19] ARM: dts: zynq: replace gpio-key,wakeup with
 wakeup-source property
In-Reply-To: <1445422216-29375-20-git-send-email-sudeep.holla@arm.com>
References: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
 <1445422216-29375-20-git-send-email-sudeep.holla@arm.com>
Message-ID: <5631DF5B.5040208@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/21/2015 12:10 PM, Sudeep Holla wrote:
> Though the keyboard driver for GPIO buttons(gpio-keys) will continue to
> check for/support the legacy "gpio-key,wakeup" boolean property to
> enable gpio buttons as wakeup source, "wakeup-source" is the new
> standard binding.
> 
> This patch replaces the legacy "gpio-key,wakeup" with the unified
> "wakeup-source" property in order to avoid any futher copy-paste
> duplication.
> 
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: "S?ren Brinkmann" <soren.brinkmann@xilinx.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/arm/boot/dts/zynq-zc702.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
> index 5df8f81f4217..cb64209bca08 100644
> --- a/arch/arm/boot/dts/zynq-zc702.dts
> +++ b/arch/arm/boot/dts/zynq-zc702.dts
> @@ -43,14 +43,14 @@
>  			label = "sw14";
>  			gpios = <&gpio0 12 0>;
>  			linux,code = <108>; /* down */
> -			gpio-key,wakeup;
> +			wakeup-source;
>  			autorepeat;
>  		};
>  		sw13 {
>  			label = "sw13";
>  			gpios = <&gpio0 14 0>;
>  			linux,code = <103>; /* up */
> -			gpio-key,wakeup;
> +			wakeup-source;
>  			autorepeat;
>  		};
>  	};
> 

Applied to zynq/dt.

Thanks,
Michal
