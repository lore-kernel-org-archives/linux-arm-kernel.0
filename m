From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 3 May 2018 08:06:15 -0700
Subject: [PATCH] ARM: dts: cygnus: fix irq type for arm global timer
In-Reply-To: <20180503094445.324-1-peron.clem@gmail.com>
References: <20180503094445.324-1-peron.clem@gmail.com>
Message-ID: <a5149af0-788a-e368-4f98-e228100360de@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Clement,

Adding Ray, Scott, Eric and bcm-kernel-feedback-list

On 05/03/2018 02:44 AM, Cl?ment P?ron wrote:
> As per ARM documentation
> PPI(0) ID27 - global timer interrupt is rising-edge sensitive.
> 
> set IRQ triggering type to IRQ_TYPE_EDGE_RISING for ARM Global timers.

This looks right and consistent with what was done on other iProc
processors (BCM5301x, NSP etc.). Would you mind providing an appropriate
Fixes: tag such that this can get backported to stable trees as well?

Thanks!

> 
> Signed-off-by: Cl?ment P?ron <peron.clem@gmail.com>
> ---
>  arch/arm/boot/dts/bcm-cygnus.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
> index 699fdf94d139..9fe4f5a6379e 100644
> --- a/arch/arm/boot/dts/bcm-cygnus.dtsi
> +++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
> @@ -69,7 +69,7 @@
>  		timer at 20200 {
>  			compatible = "arm,cortex-a9-global-timer";
>  			reg = <0x20200 0x100>;
> -			interrupts = <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts = <GIC_PPI 11 IRQ_TYPE_EDGE_RISING>;
>  			clocks = <&periph_clk>;
>  		};
>  
> 

-- 
Florian
