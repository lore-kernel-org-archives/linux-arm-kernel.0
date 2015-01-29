From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 29 Jan 2015 13:42:32 +0100
Subject: [PATCH 3/3] cpufreq: exynos: allow modular build
In-Reply-To: <CAKohpo=An5Jm4qfhWaE96hPKyKVQfsZPdvrgxKH2ymvyvgQ_pQ@mail.gmail.com>
References: <1422451015-390439-1-git-send-email-arnd@arndb.de>
 <2157802.ranbh8xTdL@wuerfel>
 <CAKohpo=An5Jm4qfhWaE96hPKyKVQfsZPdvrgxKH2ymvyvgQ_pQ@mail.gmail.com>
Message-ID: <1642077.OrkdxhO2uI@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 29 January 2015 15:40:15 Viresh Kumar wrote:
>  obj-$(CONFIG_ARCH_DAVINCI)             += davinci-cpufreq.o
>  obj-$(CONFIG_UX500_SOC_DB8500)         += dbx500-cpufreq.o
> -obj-$(CONFIG_ARM_EXYNOS_CPUFREQ)       += exynos-cpufreq.o
> -obj-$(CONFIG_ARM_EXYNOS4210_CPUFREQ)   += exynos4210-cpufreq.o
> -obj-$(CONFIG_ARM_EXYNOS4X12_CPUFREQ)   += exynos4x12-cpufreq.o
> -obj-$(CONFIG_ARM_EXYNOS5250_CPUFREQ)   += exynos5250-cpufreq.o
> +obj-$(CONFIG_ARM_EXYNOS4210_CPUFREQ)   += exynos-cpufreq.o exynos4210-cpufreq.o
> +obj-$(CONFIG_ARM_EXYNOS4X12_CPUFREQ)   += exynos-cpufreq.o exynos4x12-cpufreq.o
> +obj-$(CONFIG_ARM_EXYNOS5250_CPUFREQ)   += exynos-cpufreq.o exynos5250-cpufreq.o
> 

I'd have to try it, but this might fail if one of the three drivers
is built-in and another one is a module.

	Arnd
