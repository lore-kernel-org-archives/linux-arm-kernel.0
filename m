From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 16 Feb 2012 21:17:30 +0900
Subject: [CPUFREQ] Fix exposure of ARM_EXYNOS4210_CPUFREQ
In-Reply-To: <20120213094940.GA15338@n2100.arm.linux.org.uk>
References: <20120213094940.GA15338@n2100.arm.linux.org.uk>
Message-ID: <4F3CF3DA.7000806@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/13/12 18:49, Russell King - ARM Linux wrote:
> From: Russell King<rmk+kernel@arm.linux.org.uk>
>
> exynos4210-cpufreq.c is not buildable on non-exynos builds, so it's
> pointless allowing this option to be exposed.  Fix this by adding a
> dependency on ARCH_EXYNOS.
>
> drivers/cpufreq/exynos4210-cpufreq.c:20:29: error: mach/regs-clock.h: No such file or directory
> drivers/cpufreq/exynos4210-cpufreq.c:21:26: error: mach/cpufreq.h: No such file or directory
>
> Signed-off-by: Russell King<rmk+kernel@arm.linux.org.uk>
> Cc: Dave Jones<davej@redhat.com>
> Cc: cpufreq at vger.kernel.org
> Cc: Kukjin Kim<kgene.kim@samsung.com>
> ---
>   drivers/cpufreq/Kconfig.arm |    1 +
>   1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index e0664fe..c8bde43 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -34,6 +34,7 @@ config ARM_EXYNOS_CPUFREQ
>
>   config ARM_EXYNOS4210_CPUFREQ
>   	bool "Samsung EXYNOS4210"
> +	depends on ARCH_EXYNOS
>   	help
>   	  This adds the CPUFreq driver for Samsung EXYNOS4210
>   	  SoC (S5PV310 or S5PC210).
>

Yes, you're right. Should be added it.
BTW, how about following?

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index e0664fe..a5e0487 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -33,7 +33,7 @@ config ARM_EXYNOS_CPUFREQ
           If in doubt, say N.

  config ARM_EXYNOS4210_CPUFREQ
-       bool "Samsung EXYNOS4210"
+       bool
         help
           This adds the CPUFreq driver for Samsung EXYNOS4210
           SoC (S5PV310 or S5PC210).

I think, when selecting "ARM_EXYNOS_CPUFREQ", "ARM_EXYNOS4210_CPUFREQ" 
will be selected on EXYNOS4210 with above changes.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
