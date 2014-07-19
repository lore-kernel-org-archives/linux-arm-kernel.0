From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 19 Jul 2014 15:29:48 +0200
Subject: [PATCH v7 6/6] cpufreq: exynos: remove exynos4210/5250 specific
 cpufreq driver support
In-Reply-To: <1405345118-4269-7-git-send-email-thomas.ab@samsung.com>
References: <1405345118-4269-1-git-send-email-thomas.ab@samsung.com>
 <1405345118-4269-7-git-send-email-thomas.ab@samsung.com>
Message-ID: <53CA72CC.7010505@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 14.07.2014 15:38, Thomas Abraham wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
> 
> Exynos4210 and Exynos5250 based platforms have switched over to use generic
> cpufreq drivers for cpufreq functionality. So the Exynos specific cpufreq
> drivers for these platforms can be removed.
> 
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> Tested-by: Arjun K.V <arjun.kv@samsung.com>
> ---
>  drivers/cpufreq/Kconfig.arm          |   22 ----
>  drivers/cpufreq/Makefile             |    2 -
>  drivers/cpufreq/exynos4210-cpufreq.c |  184 -----------------------------
>  drivers/cpufreq/exynos5250-cpufreq.c |  210 ----------------------------------
>  4 files changed, 418 deletions(-)
>  delete mode 100644 drivers/cpufreq/exynos4210-cpufreq.c
>  delete mode 100644 drivers/cpufreq/exynos5250-cpufreq.c
> 

I would hesitate with removing this driver straightaway and replacing it
with a new one that isn't yet well tested. For at least one release I
would keep the old code in place with the possibility of switching
between old and new one in Kconfig.

Best regards,
Tomasz
