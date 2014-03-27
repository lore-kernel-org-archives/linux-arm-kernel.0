From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 27 Mar 2014 11:12:10 +0000
Subject: [PATCH] arm64: Fix duplicated Kconfig entries again
In-Reply-To: <533163D4.6030205@linaro.org>
References: <1395738060-18489-1-git-send-email-hanjun.guo@linaro.org>
 <533153BF.3070308@arm.com> <533163D4.6030205@linaro.org>
Message-ID: <5334078A.9010408@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hanjun,

On 25/03/14 11:09, Hanjun Guo wrote:
> Hi Sudeep,
> 
> On 2014-3-25 18:00, Sudeep Holla wrote:
>> Hi Hanjun,
>>
>> On 25/03/14 09:00, Hanjun Guo wrote:
>>> After commit 74397174989e5 (arm64: Fix duplicated Kconfig entries),
>>> I still get a duplicate Power management options section in linux-next
>>> git repo, may be due to some merge conflicts, anyway, fix that in this
>>> patch.
>>>
>> I reported this and Mark Brown posted the patch[1].
>> I assumed it is already pulled, but looks like that's not the case.
> [...]
>> [1] http://www.spinics.net/lists/arm-kernel/msg314472.html

[...]

> here is the link:
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/arch/arm64/Kconfig
> 

Just had a look at the linux-next tree and looks like the original commit:
"cpufreq: enable ARM drivers on arm64" is pulled by both Catalin and Rafael
which has resulted in the fixup patch[1] not removing the duplicate entry
cleanly.

If not too late it better to ask either Rafael or Catalin to drop both patches
from their tree, instead of creating 4 patches in total to enable cpufreq :)

Regards,
Sudeep
