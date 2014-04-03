From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 03 Apr 2014 17:27:28 +0800
Subject: [PATCH] arm64: Fix duplicated Kconfig entries again
In-Reply-To: <20140403085120.GB17022@arm.com>
References: <1395738060-18489-1-git-send-email-hanjun.guo@linaro.org>
 <5334078A.9010408@arm.com> <53341ADF.2050904@linaro.org>
 <2765234.k5FCzWzCDz@vostro.rjw.lan> <533D1D5E.20208@linaro.org>
 <CAOh2x=nYWjB+Org6eNjQAT93ZX2DRHNYSJWgWTo8vS2AmdrAbA@mail.gmail.com>
 <20140403085120.GB17022@arm.com>
Message-ID: <533D2980.6000903@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-4-3 16:51, Catalin Marinas wrote:
> On Thu, Apr 03, 2014 at 09:41:57AM +0100, Viresh Kumar wrote:
>> On Thu, Apr 3, 2014 at 2:05 PM, Hanjun Guo <hanjun.guo@linaro.org> wrote:
>>> How about the following patch? if it is ok, I will resend it.
>>
>> http://www.spinics.net/lists/arm-kernel/msg319545.html
> 
> I can see commit 62d1a3ba5adc5653d43f6cd3a90758bb6ad5d5bd (arm64: Fix
> duplicated Kconfig entries again) already in mainline, so problem
> solved.
> 
> Thanks Josh ;)

Great, thanks Viresh to let me know this.
Actually I also sent a patch named "arm64: Fix duplicated Kconfig entries
again" about one week ago :)

https://www.mail-archive.com/linux-kernel at vger.kernel.org/msg612363.html

And I think there is still a problem after commit 62d1a3ba - multi-entries
for source "kernel/power/Kconfig", so how about the following fix?

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e6e4d37..6085dca 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -317,14 +317,8 @@ config ARCH_SUSPEND_POSSIBLE
 config ARM64_CPU_SUSPEND
        def_bool PM_SLEEP

-endmenu
-
-menu "CPU Power Management"
-
 source "drivers/cpuidle/Kconfig"

-source "kernel/power/Kconfig"
-
 source "drivers/cpufreq/Kconfig"

 endmenu

If it makes sense, I will send out a patch for it.

Thanks
Hanjun
