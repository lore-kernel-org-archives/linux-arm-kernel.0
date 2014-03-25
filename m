From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 25 Mar 2014 19:09:08 +0800
Subject: [PATCH] arm64: Fix duplicated Kconfig entries again
In-Reply-To: <533153BF.3070308@arm.com>
References: <1395738060-18489-1-git-send-email-hanjun.guo@linaro.org>
 <533153BF.3070308@arm.com>
Message-ID: <533163D4.6030205@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudeep,

On 2014-3-25 18:00, Sudeep Holla wrote:
> Hi Hanjun,
> 
> On 25/03/14 09:00, Hanjun Guo wrote:
>> After commit 74397174989e5 (arm64: Fix duplicated Kconfig entries),
>> I still get a duplicate Power management options section in linux-next
>> git repo, may be due to some merge conflicts, anyway, fix that in this
>> patch.
>>
> I reported this and Mark Brown posted the patch[1].
> I assumed it is already pulled, but looks like that's not the case.
[...]
> [1] http://www.spinics.net/lists/arm-kernel/msg314472.html

Yes, I noticed this patch in arm maillist, and I can see that this
patch was already merged into linux-next, but I still got duplicate
Power management options in the Kconfig:
---------------------------------
menu "Power management options"

source "kernel/power/Kconfig"

config ARCH_SUSPEND_POSSIBLE
	def_bool y

config ARM64_CPU_SUSPEND
	def_bool PM_SLEEP

endmenu

menu "CPU Power Management"

source "drivers/cpuidle/Kconfig"

source "drivers/cpufreq/Kconfig"

endmenu

menu "Power management options"

source "kernel/power/Kconfig"

source "drivers/cpufreq/Kconfig"

endmenu
--------------------------------
here is the link:
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/arch/arm64/Kconfig

Thanks
Hanjun
> 
