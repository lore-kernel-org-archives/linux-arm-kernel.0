From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 03 Apr 2014 16:35:42 +0800
Subject: [PATCH] arm64: Fix duplicated Kconfig entries again
In-Reply-To: <2765234.k5FCzWzCDz@vostro.rjw.lan>
References: <1395738060-18489-1-git-send-email-hanjun.guo@linaro.org>
 <5334078A.9010408@arm.com> <53341ADF.2050904@linaro.org>
 <2765234.k5FCzWzCDz@vostro.rjw.lan>
Message-ID: <533D1D5E.20208@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

Sorry the late reply.

On 2014-3-27 23:18, Rafael J. Wysocki wrote:
[...]
>>> Just had a look at the linux-next tree and looks like the original commit:
>>> "cpufreq: enable ARM drivers on arm64" is pulled by both Catalin and Rafael
>>> which has resulted in the fixup patch[1] not removing the duplicate entry
>>> cleanly.
>>>
>>> If not too late it better to ask either Rafael or Catalin to drop both patches
>>> from their tree, instead of creating 4 patches in total to enable cpufreq :)
>>
>> Rafael is on vacation now.
>>
>> Catalin, could you please handle this?
> 
> Well, not really, I'm at a conference now.

Oops...

> 
> Anyway, I'd rather not drop anything, but if you send me a revert, I can apply it.

Mark Brown sent another patch to fix this problem, and that patch already merged
into mainline, but the problem is still there, so I think a single revert will
not help.

How about the following patch? if it is ok, I will resend it.

After commit 74397174989e5 (arm64: Fix duplicated Kconfig entries),
I still get a duplicate Power management options section in linux-next
git repo, may be due to some merge conflicts, anyway, fix that in this
patch.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
Based on linux-next repo, weird, did I miss something?
---
 arch/arm64/Kconfig |   12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index d9f23ad..6085dca 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -317,24 +317,12 @@ config ARCH_SUSPEND_POSSIBLE
 config ARM64_CPU_SUSPEND
 	def_bool PM_SLEEP

-endmenu
-
-menu "CPU Power Management"
-
 source "drivers/cpuidle/Kconfig"

 source "drivers/cpufreq/Kconfig"

 endmenu

-menu "Power management options"
-
-source "kernel/power/Kconfig"
-
-source "drivers/cpufreq/Kconfig"
-
-endmenu
-
 source "net/Kconfig"

 source "drivers/Kconfig"
