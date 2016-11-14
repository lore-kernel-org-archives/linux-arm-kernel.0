From: liviu.dudau@arm.com (Liviu Dudau)
Date: Mon, 14 Nov 2016 17:32:52 +0000
Subject: [PATCH] arm64: dts: juno: fix cluster sleep state entry latency
 on all SoC versions
In-Reply-To: <1479137189-15378-1-git-send-email-sudeep.holla@arm.com>
References: <1479137189-15378-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <20161114173252.GP10219@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 14, 2016 at 03:26:29PM +0000, Sudeep Holla wrote:
> The core and the cluster sleep state entry latencies can't be same as
> cluster sleep involves more work compared to core level e.g. shared
> cache maintenance.
> 
> Experiments have shown on an average about 100us more latency for the
> cluster sleep state compared to the core level sleep. This patch fixes
> the entry latency for the cluster sleep state.
> 
> Fixes: 28e10a8f3a03 ("arm64: dts: juno: Add idle-states to device tree")
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: "Jon Medhurst (Tixy)" <tixy@linaro.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Looks sensible to me.

Reviewed-by: Liviu Dudau <Liviu.Dudau@arm.com>

> ---
>  arch/arm64/boot/dts/arm/juno-r1.dts | 2 +-
>  arch/arm64/boot/dts/arm/juno-r2.dts | 2 +-
>  arch/arm64/boot/dts/arm/juno.dts    | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> Hi,
> 
> This was found recently when I found that core sleep was chosen when
> entering suspend-to-idle state on Juno. Since the wakeup(entry+exit)
> latency matched for the both states, cpu sleep state was chosen to enter
> in suspend-to-idle.
> 
> Regards,
> Sudeep
> 
> diff --git a/arch/arm64/boot/dts/arm/juno-r1.dts b/arch/arm64/boot/dts/arm/juno-r1.dts
> index 3be8a3ef671c..eec37feee8fc 100644
> --- a/arch/arm64/boot/dts/arm/juno-r1.dts
> +++ b/arch/arm64/boot/dts/arm/juno-r1.dts
> @@ -76,7 +76,7 @@
>  				compatible = "arm,idle-state";
>  				arm,psci-suspend-param = <0x1010000>;
>  				local-timer-stop;
> -				entry-latency-us = <300>;
> +				entry-latency-us = <400>;
>  				exit-latency-us = <1200>;
>  				min-residency-us = <2500>;
>  			};
> diff --git a/arch/arm64/boot/dts/arm/juno-r2.dts b/arch/arm64/boot/dts/arm/juno-r2.dts
> index 614fc9227943..28f40ec44090 100644
> --- a/arch/arm64/boot/dts/arm/juno-r2.dts
> +++ b/arch/arm64/boot/dts/arm/juno-r2.dts
> @@ -76,7 +76,7 @@
>  				compatible = "arm,idle-state";
>  				arm,psci-suspend-param = <0x1010000>;
>  				local-timer-stop;
> -				entry-latency-us = <300>;
> +				entry-latency-us = <400>;
>  				exit-latency-us = <1200>;
>  				min-residency-us = <2500>;
>  			};
> diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
> index 6b4135e9cfe5..ac5ceb73f45f 100644
> --- a/arch/arm64/boot/dts/arm/juno.dts
> +++ b/arch/arm64/boot/dts/arm/juno.dts
> @@ -76,7 +76,7 @@
>  				compatible = "arm,idle-state";
>  				arm,psci-suspend-param = <0x1010000>;
>  				local-timer-stop;
> -				entry-latency-us = <300>;
> +				entry-latency-us = <400>;
>  				exit-latency-us = <1200>;
>  				min-residency-us = <2500>;
>  			};
> --
> 2.7.4
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
