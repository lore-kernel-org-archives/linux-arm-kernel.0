From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 17 Jan 2014 11:15:50 +0100
Subject: [PATCH] arch_timer: Move delay timer to drivers clocksource
In-Reply-To: <52D901B6.1070800@nvidia.com>
References: <1389791227-24097-1-git-send-email-pgaikwad@nvidia.com>	<20140115154526.GC3571@mudshark.cambridge.arm.com>	<52D76BC8.6080405@nvidia.com>	<20140116121649.GG30257@mudshark.cambridge.arm.com>
 <878uufyo13.fsf@iki.fi> <52D8F403.9070602@linaro.org>
 <52D901B6.1070800@nvidia.com>
Message-ID: <52D902D6.3090208@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/17/2014 11:11 AM, Prashant Gaikwad wrote:
> On Friday 17 January 2014 02:42 PM, Daniel Lezcano wrote:
>> On 01/17/2014 10:07 AM, Antti Miettinen wrote:
>>> Will Deacon <will.deacon@arm.com> writes:
>>>> Why can't you use the C3STOP feature so that the arch-timer isn't
>>>> used when
>>>> you go idle?
>>> That would mean falling back to broadcast timer, right? That's not
>>> necessarily on the local CPU so wakeups would often wake two CPUs.
>> You can prevent that if the hardware supports it with the
>> CLOCK_EVT_DYNIRQ flag on the broadcast timer.
>
> Instead of falling back on broadcast timer, is it possible to fall back
> on other per-CPU timer which is preserved across idle state?

Is it what you are looking for ?

http://lwn.net/Articles/580568/


>>> Does
>>> anyone have patches for using a CPU local timer as a fallback for
>>> C3STOP timers?
>>
>>
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
