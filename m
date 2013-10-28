From: khilman@linaro.org (Kevin Hilman)
Date: Sun, 27 Oct 2013 18:32:26 -0700
Subject: [tip:timers/core] ARM: Kconfig: allow full nohz CPU accounting
In-Reply-To: <20131018163740.GA21983@codeaurora.org>
References: <tip-31c1fc8187158cb80ccd57c19e024c55af901797@git.kernel.org>
 <20131016121416.GD12773@localhost.localdomain>
 <20131018163740.GA21983@codeaurora.org>
Message-ID: <526DBEAA.4030707@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On 10/18/2013 09:37 AM, Stephen Boyd wrote:
> On 10/16, Frederic Weisbecker wrote:
>> On Thu, Oct 03, 2013 at 06:58:03AM -0700, tip-bot for Kevin Hilman wrote:
>>> Commit-ID:  31c1fc8187158cb80ccd57c19e024c55af901797
>>> Gitweb:     http://git.kernel.org/tip/31c1fc8187158cb80ccd57c19e024c55af901797
>>> Author:     Kevin Hilman <khilman@linaro.org>
>>> AuthorDate: Mon, 16 Sep 2013 15:28:22 -0700
>>> Committer:  Frederic Weisbecker <fweisbec@gmail.com>
>>> CommitDate: Mon, 30 Sep 2013 15:37:05 +0200
>>>
>>> ARM: Kconfig: allow full nohz CPU accounting
>>>
>>> With the 64-bit requirement removed from VIRT_CPU_ACCOUNTING_GEN,
>>> allow ARM platforms to enable it.  Since VIRT_CPU_ACCOUNTING_GEN is a
>>> dependency for full NO_HZ, this allows ARM platforms to enable full
>>> NO_HZ as well.
>>
>> I realize that arm doesn't implement irq work raise. It hooks on the
>> timer to execute pending irq work. You'll need to implement arch_irq_work_raise()
>> and implement some sort of self IPI to trigger irq work. The full dynticks subsystem
>> relies on that to work correctly. It often use that to re-evaluate and possibly restart
>> the tick after scheduler, posix timer updates, etc...
>>
>> That notwithstanding that if you have no tick, tick based irq work can't
>> work.
>>
> 
> Something like this? The only problem is that this latches on to
> the SMP support for IPIs. If CONFIG_SMP is disabled we won't get
> arch_irq_work_raise() but perhaps that isn't so big of a deal? Or
> we should think about exposing IPI support to UP systems on ARM.

Care to submit a proper patch for this to LAKML?  or if you prefer I can
do it (keeping your authorship.)   We need this for proper full NOHZ
support on ARM.  Thanks.

Kevin
