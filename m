From: afd@ti.com (Andrew F. Davis)
Date: Fri, 5 Oct 2018 10:51:13 -0500
Subject: [PATCH 2/2] pwm: Kconfig: Enable TI ECAP driver for ARCH_K3
In-Reply-To: <20181003170658.3835-3-vigneshr@ti.com>
References: <20181003170658.3835-1-vigneshr@ti.com>
 <20181003170658.3835-3-vigneshr@ti.com>
Message-ID: <ef269f60-b92d-c8af-77b2-d3d299814b5c@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/03/2018 12:06 PM, Vignesh R wrote:
> K3 devices have the same ECAP IP as OMAP SoC. Enable driver to be built
> for K3 devices.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
>  drivers/pwm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 504d252716f2..0c7bc6f554cf 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -447,7 +447,7 @@ config PWM_TEGRA
>  
>  config  PWM_TIECAP
>  	tristate "ECAP PWM support"
> -	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX || ARCH_KEYSTONE
> +	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX || ARCH_KEYSTONE || ARCH_K3
>  	help
>  	  PWM driver support for the ECAP APWM controller found on AM33XX
>  	  TI SOC
> 

Minor, perhaps calling out AM33XX specifically in the help text is no
longer needed and a bit confusing.

Andrew
