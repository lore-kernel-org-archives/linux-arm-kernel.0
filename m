From: afzal@ti.com (Mohammed, Afzal)
Date: Fri, 19 Oct 2012 10:54:53 +0000
Subject: [PATCH] arm/dts: am33xx rtc node
In-Reply-To: <1350643825-9657-1-git-send-email-afzal@ti.com>
References: <1350643825-9657-1-git-send-email-afzal@ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93EA00AFC@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ linux-omap and Daniel

On Fri, Oct 19, 2012 at 16:20:21, Mohammed, Afzal wrote:
> add am33xx rtc node.
> 
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> ---
> 
> Based on v3.7-rc1,
> Dependent on series "rtc: omap dt support (for am33xx)",
> (https://lkml.org/lkml/2012/10/19/163)
> Tested on Beagle Bone.
> 
>  arch/arm/boot/dts/am33xx.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index bb31bff..356711e 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -210,5 +210,14 @@
>  			interrupt-parent = <&intc>;
>  			interrupts = <91>;
>  		};
> +
> +		rtc {
> +			compatible = "ti,da830-rtc";
> +			ti,hwmods = "rtc";
> +			reg = <0x44e3e000 0x1000>;
> +			interrupt-parent = <&intc>;
> +			interrupts = <75
> +				      76>;
> +		};
>  	};
>  };
> -- 
> 1.7.12
> 
> 
