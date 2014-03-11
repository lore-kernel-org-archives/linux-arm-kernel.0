From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 11 Mar 2014 13:59:34 +0000
Subject: [PATCH] arm64: Fix duplicated Kconfig entries
In-Reply-To: <1394543851-11732-1-git-send-email-broonie@kernel.org>
References: <1394543851-11732-1-git-send-email-broonie@kernel.org>
Message-ID: <531F16C6.5030903@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 11/03/14 13:17, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
>
> Probably due to rebasing over the lengthy time it took to get the patch
> merged commit addea9ef055b (cpufreq: enable ARM drivers on arm64) added
> a duplicate Power management options section.  Add CPUfreq to the CPU
> power management section and remove a duplicate include of the main
> power section.
>

This looks fine to me, but since commit addea9ef055b is only in Rafael's
next tree, Catalin can't take this, so it makes sense to go through Rafael's
tree, right ?

Regards,
Sudeep

> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>   arch/arm64/Kconfig | 6 ------
>   1 file changed, 6 deletions(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index a3c40d65128b..2474c24dc229 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -318,12 +318,6 @@ menu "CPU Power Management"
>
>   source "drivers/cpuidle/Kconfig"
>
> -endmenu
> -
> -menu "Power management options"
> -
> -source "kernel/power/Kconfig"
> -
>   source "drivers/cpufreq/Kconfig"
>
>   endmenu
>
