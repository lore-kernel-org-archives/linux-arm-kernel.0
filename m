From: lauraa@codeaurora.org (Laura Abbott)
Date: Wed, 25 Feb 2015 10:04:50 -0800
Subject: [PATCH] drivers: cpuidle: Explictly include proc-fns.h for
 cpuidle-arm64
In-Reply-To: <20150225112758.GB20214@red-moon>
References: <1424827506-12245-1-git-send-email-lauraa@codeaurora.org>
 <20150225111828.GA9714@leverpostej> <20150225112758.GB20214@red-moon>
Message-ID: <54EE0EC2.3090408@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/25/2015 3:27 AM, Lorenzo Pieralisi wrote:
> On Wed, Feb 25, 2015 at 11:18:29AM +0000, Mark Rutland wrote:
>
> [...]
>
>>>   drivers/cpuidle/cpuidle-arm64.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/cpuidle/cpuidle-arm64.c b/drivers/cpuidle/cpuidle-arm64.c
>>> index 80704b9..f1d5422 100644
>>> --- a/drivers/cpuidle/cpuidle-arm64.c
>>> +++ b/drivers/cpuidle/cpuidle-arm64.c
>>> @@ -19,6 +19,7 @@
>>>   #include <linux/of.h>
>>>
>>>   #include <asm/cpuidle.h>
>>> +#include <asm/proc-fns.h>
>>>   #include <asm/suspend.h>
>>
>> I wasn't able to apply this patch atop of v4.0-rc1 or current mainline;
>> there's no asm/suspend.h include in either of those. Which tree is this
>> based on?
>
> Yes, it does not apply to mainline, either we fix that up or here is
> the version I was sending on top of mainline.
>
> Thanks,
> Lorenzo
>

Blah, I forgot I had cruft in my tree. Sorry about that.

> -- >8 --
> Subject: [PATCH] drivers: cpuidle: cpuidle-arm64: include asm/proc-fns.h
>   explicitly
>
> ARM64 CPUidle driver requires the cpu_do_idle function so that it can
> be used to enter the shallowest idle state, and it is declared in
> asm/proc-fns.h.
>
> This patch adds the explicit inclusion of the asm/proc-fns.h header file
> to stop relying on implicit inclusion of the same file through implicit
> header files dependencies.
>
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> [lp: rebased/rewrote commit log]
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>   drivers/cpuidle/cpuidle-arm64.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cpuidle/cpuidle-arm64.c b/drivers/cpuidle/cpuidle-arm64.c
> index 39a2c62..c8bb6c5 100644
> --- a/drivers/cpuidle/cpuidle-arm64.c
> +++ b/drivers/cpuidle/cpuidle-arm64.c
> @@ -19,6 +19,7 @@
>   #include <linux/of.h>
>
>   #include <asm/cpuidle.h>
> +#include <asm/proc-fns.h>
>
>   #include "dt_idle_states.h"
>
>


-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
