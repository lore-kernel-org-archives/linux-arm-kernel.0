From: robherring2@gmail.com (Rob Herring)
Date: Mon, 29 Oct 2012 12:22:56 -0500
Subject: [PATCH] ARM: highbank: retry wfi on reset request
In-Reply-To: <1351221637-21747-1-git-send-email-robherring2@gmail.com>
References: <1351221637-21747-1-git-send-email-robherring2@gmail.com>
Message-ID: <508EBB70.2000708@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/25/2012 10:20 PM, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> In some cases, an interrupt can occur and prevent cause failure to enter
> wfi. This causes reset to hang. Retrying the wfi should be enough to
> prevent reset from hanging.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---

Arnd, Olof,

Can you please apply this for 3.7?

Rob

>  arch/arm/mach-highbank/system.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-highbank/system.c b/arch/arm/mach-highbank/system.c
> index 82c2723..86e37cd 100644
> --- a/arch/arm/mach-highbank/system.c
> +++ b/arch/arm/mach-highbank/system.c
> @@ -28,6 +28,7 @@ void highbank_restart(char mode, const char *cmd)
>  		hignbank_set_pwr_soft_reset();
>  
>  	scu_power_mode(scu_base_addr, SCU_PM_POWEROFF);
> -	cpu_do_idle();
> +	while (1)
> +		cpu_do_idle();
>  }
>  
> 
