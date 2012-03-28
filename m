From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 28 Mar 2012 16:51:32 +0530
Subject: [PATCH] ARM: Samsung: Make PM_GENERIC_DOMAINS config depend on
 CONFIG_PM
In-Reply-To: <20120328105122.GF3232@opensource.wolfsonmicro.com>
References: <1332843404-25476-1-git-send-email-thomas.ab@samsung.com>
 <20120328105122.GF3232@opensource.wolfsonmicro.com>
Message-ID: <CAJuYYwQgZqN6nguddjS6bjLhx_ZhUZ5AfcrSAKBa7Ft-Bn6wPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 March 2012 16:21, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Mar 27, 2012 at 03:46:43PM +0530, Thomas Abraham wrote:
>> For s3c64xx and exynos platforms, make the selection of PM_GENERIC_DOMAINS
>> depend on the CONFIG_PM.
>
> What's the underlying issue here? ?This seems like something the PM core
> should be dealing with gracefully...

The PM_GENERIC_DOMAINS config option has dependency on CONFIG_PM
option. When building with PM disabled, the following errors occur.

warning: (PLAT_S3C64XX && CPU_EXYNOS4210) selects PM_GENERIC_DOMAINS
which has unmet direct dependencies (PM)
warning: (MACH_EXYNOS5_DT) selects SOC_EXYNOS5250 which has unmet
direct dependencies (ARCH_EXYNOS && ARCH_EXYNOS5)
warning: (PLAT_S3C64XX && CPU_EXYNOS4210) selects PM_GENERIC_DOMAINS
which has unmet direct dependencies (PM)
warning: (MACH_EXYNOS5_DT) selects SOC_EXYNOS5250 which has unmet
direct dependencies (ARCH_EXYNOS && ARCH_EXYNOS5)

[...]

drivers/base/power/domain.c: In function '__pm_genpd_add_device':
drivers/base/power/domain.c:1132: error: implicit declaration of
function 'genpd_acquire_lock'
drivers/base/power/domain.c:1168: error: implicit declaration of
function 'genpd_release_lock'
drivers/base/power/domain.c: In function 'pm_genpd_add_subdomain':
drivers/base/power/domain.c:1298: error: implicit declaration of
function 'genpd_sd_counter_inc'
drivers/base/power/domain.c: In function 'pm_genpd_remove_subdomain':
drivers/base/power/domain.c:1341: error: implicit declaration of
function 'genpd_sd_counter_dec'
make[3]: *** [drivers/base/power/domain.o] Error 1

Thanks,
Thomas.
