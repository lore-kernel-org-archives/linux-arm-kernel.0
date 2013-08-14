From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Wed, 14 Aug 2013 12:03:27 +0100
Subject: [PATCH v3 0/6] ARM/ARM64 architected timer updates
In-Reply-To: <520B611D.8060500@linaro.org>
References: <1374492082-13686-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376414984-14182-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <520B490A.4090109@linaro.org> <520B4B2E.1040700@arm.com>
 <520B611D.8060500@linaro.org>
Message-ID: <520B63FF.3090805@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/08/13 11:51, Daniel Lezcano wrote:
> On 08/14/2013 11:17 AM, Sudeep KarkadaNagesha wrote:
>> On 14/08/13 10:08, Daniel Lezcano wrote:
>>> On 08/13/2013 07:29 PM, Sudeep KarkadaNagesha wrote:
>>>> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>>>>
>>>> This patch series adds support to configure the rate and enable the
>>>> event stream for architected timer. The event streams can be used to
>>>> impose a timeout on a WFE, to safeguard against any programming error
>>>> in case an expected event is not generated or even to implement
>>>> wfe-based timeouts for userspace locking implementations.
>>>>
>>>> Since the timer control register is reset to zero on warm boot, CPU
>>>> PM notifier is added to re-initialize it.
>>>
>>> It does not apply to my tree.
>>>
>>> Against which tree is this patchset ? Who is supposed to take it ?
>>>
>> As I had mentioned in previous version, because of the conflict, I had
>> to rebase it on 3.11-rc4
> 
> 
> dlezcano at mai:~/Work/src/clockevents$ git show
> commit c095ba7224d8edc71dcef0d655911399a8bd4a3f
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Sun Aug 4 13:46:46 2013 -0700
> 
>     Linux 3.11-rc4
> 
> diff --git a/Makefile b/Makefile
> index 95a8e55..f93d4f7 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1,7 +1,7 @@
>  VERSION = 3
>  PATCHLEVEL = 11
>  SUBLEVEL = 0
> -EXTRAVERSION = -rc3
> +EXTRAVERSION = -rc4
>  NAME = Linux for Workgroups
> 
>  # *DOCUMENTATION*
> 
> 
> dlezcano at mai:~/Work/src/clockevents$ git am -s arch_timer
> 
> Applying: ARM/ARM64: arch_timer: add macros for bits in control register
> Applying: drivers: clocksource: configure event stream for ARM arch timer
> Applying: ARM: arch_timer: configure and enable event stream
> Applying: ARM64: arch_timer: configure and enable event stream
Looks like you are missing a patch here:
[PATCH v3 5/6] drivers: clocksource: enable hwcaps for event stream on
ARM arch timer

> Applying: drivers: clocksource: add CPU PM notifier for ARM architected
> timer

Regards,
Sudeep
