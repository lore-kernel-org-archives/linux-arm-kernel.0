From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 03 Sep 2014 15:45:06 +0200
Subject: [Patch v3] 1/7] cpuidle: kirkwood: Remove ARCH_KIRKWOOD dependency
In-Reply-To: <1409417172-6846-2-git-send-email-andrew@lunn.ch>
References: <1409417172-6846-1-git-send-email-andrew@lunn.ch>
 <1409417172-6846-2-git-send-email-andrew@lunn.ch>
Message-ID: <54071B62.6070303@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/30/2014 06:46 PM, Andrew Lunn wrote:
> mach-kirkwood has been removed, now that kirkwood lives in mach-mvebu.
> Use MACH_KIRKWOOD, which is set when kirkwood is built as part of
> mach-mvebu.
>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: linux-pm at vger.kernel.org

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   drivers/cpuidle/Kconfig.arm | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
> index 38cff69ffe06..58bcd0d166ec 100644
> --- a/drivers/cpuidle/Kconfig.arm
> +++ b/drivers/cpuidle/Kconfig.arm
> @@ -28,7 +28,7 @@ config ARM_HIGHBANK_CPUIDLE
>
>   config ARM_KIRKWOOD_CPUIDLE
>   	bool "CPU Idle Driver for Marvell Kirkwood SoCs"
> -	depends on ARCH_KIRKWOOD || MACH_KIRKWOOD
> +	depends on MACH_KIRKWOOD
>   	help
>   	  This adds the CPU Idle driver for Marvell Kirkwood SoCs.
>
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
