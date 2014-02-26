From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 26 Feb 2014 15:15:10 +0100
Subject: [PATCH v3 5/6] pwm: enable TI PWMSS if the IIO tiecap driver is
 selected
In-Reply-To: <1391626901-31684-6-git-send-email-mporter@linaro.org>
References: <1391626901-31684-1-git-send-email-mporter@linaro.org>
 <1391626901-31684-6-git-send-email-mporter@linaro.org>
Message-ID: <20140226141508.GF29779@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 05, 2014 at 02:01:40PM -0500, Matt Porter wrote:
> The IIO TI ECAP driver depends on the TI PWMSS management
> driver in this subsystem. Enable PWMSS when the IIO TI ECAP
> driver is selected.
> 
> Signed-off-by: Matt Porter <mporter@linaro.org>
> ---
>  drivers/pwm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 22f2f28..bd3cc65 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -219,7 +219,7 @@ config  PWM_TIEHRPWM
>  
>  config  PWM_TIPWMSS
>  	bool
> -	default y if SOC_AM33XX && (PWM_TIECAP || PWM_TIEHRPWM)
> +	default y if SOC_AM33XX && (IIO_TIECAP || PWM_TIECAP || PWM_TIEHRPWM)
>  	help
>  	  PWM Subsystem driver support for AM33xx SOC.

Perhaps this module should move out of drivers/pwm if it's no longer a
PWM specific module.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140226/670f7d0f/attachment.sig>
