From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 11 Mar 2014 12:27:01 +0000
Subject: [PATCH] cpufreq: enable ARM drivers on arm64
In-Reply-To: <1393208877-15797-1-git-send-email-broonie@kernel.org>
References: <1393208877-15797-1-git-send-email-broonie@kernel.org>
Message-ID: <531F0115.4000109@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Sorry for late response, looks like Rafael has pulled this change, but ...

On 24/02/14 02:27, Mark Brown wrote:
> From: Rob Herring <rob.herring@calxeda.com>
>
> Enable cpufreq and power kconfig menus on arm64 along with arm cpufreq
> drivers. The power menu is needed for OPP support. At least on Calxeda
> systems, the same cpufreq driver is used for arm and arm64 based
> systems.
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>   arch/arm64/Kconfig      | 8 ++++++++
>   drivers/cpufreq/Kconfig | 2 +-
>   2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index fea7b47..939e95a 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -327,6 +327,14 @@ source "drivers/cpuidle/Kconfig"
>
>   endmenu
>
> +menu "Power management options"
> +
> +source "kernel/power/Kconfig"
> +
> +source "drivers/cpufreq/Kconfig"
> +
> +endmenu
> +

Is this patch based on recent kernels ? If so, either it should have caused
conflicts or silently duplicated the entries. "Power management options" are
already present.

Also to be more consistent it with menu options, I would prefer this to be
placed under "CPU Power Management" like CPUIdle.

Regards,
Sudeep
