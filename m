From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 24 Sep 2014 11:39:46 +0200
Subject: [PATCH] ARM: zynq: DT: Remove 222 MHz OPP
In-Reply-To: <1411498520-8117-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1411498520-8117-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <b5cd2f8d-f37d-4e19-a891-bd234849096d@BL2FFO11FD054.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/23/2014 08:55 PM, Soren Brinkmann wrote:
> Due to dependencies between timer and CPU frequency, only changes by
> powers of two are allowed. The clocksource driver prevents other
> changes, but with cpufreq and its governors it can result in being
> spammed with error messages constantly. Hence, remove the 222 MHz OPP.
> 
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
>  arch/arm/boot/dts/zynq-7000.dtsi | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
> index 6cc83d4c6c76..a0ed01d68328 100644
> --- a/arch/arm/boot/dts/zynq-7000.dtsi
> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
> @@ -30,7 +30,6 @@
>  				/* kHz    uV */
>  				666667  1000000
>  				333334  1000000
> -				222223  1000000
>  			>;
>  		};
>  
> 

Applied.

Thanks,
Michal
