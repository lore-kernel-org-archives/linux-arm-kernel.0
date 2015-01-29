From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 29 Jan 2015 09:09:03 +0530
Subject: [PATCH 3/3] cpufreq: exynos: allow modular build
In-Reply-To: <1799972.nQ2Axu0CEJ@wuerfel>
References: <1422451015-390439-1-git-send-email-arnd@arndb.de>
 <1422451015-390439-4-git-send-email-arnd@arndb.de>
 <20150128172209.GF29600@developer.hsd1.ca.comcast.net>
 <1799972.nQ2Axu0CEJ@wuerfel>
Message-ID: <CAKohpom9L4jiMRGn3OaWyYM7iR3Ame4-LKG144yuHmRxCJud3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 January 2015 at 01:31, Arnd Bergmann <arnd@arndb.de> wrote:

>>  config ARM_EXYNOS_CPUFREQ
>> -     bool
>> +     tristate "SAMSUNG EXYNOS CPUfreq Driver"
>> +     depends on THERMAL
>> +     default y
>> +     help
>> +       This adds the CPUFreq driver for Samsung EXYNOS platforms
>> +
>> +       If in doubt, say N.
>
> Now the option shows up on all systems that include Kconfig.arm,
> in particular non-exynos machines that might not even be able
> to build this.

I am sure I am wrong here, but want to know what I am missing.
What about:

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index c3c3cf52d2d9..f3ee05067a69 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -27,7 +27,7 @@ config ARM_VEXPRESS_SPC_CPUFREQ

 config ARM_EXYNOS_CPUFREQ
        tristate "SAMSUNG EXYNOS CPUfreq Driver"
-       depends on THERMAL
+       depends on THERMAL && ARCH_EXYNOS
        default y
        help
          This adds the CPUFreq driver for Samsung EXYNOS platforms
