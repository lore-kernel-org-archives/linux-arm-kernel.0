From: john.stultz@linaro.org (John Stultz)
Date: Wed, 09 Oct 2013 16:59:18 -0700
Subject: [PATCH] sched_clock: fix postinit no sched_clock function check
In-Reply-To: <524C60F4.7000802@ti.com>
References: <1380732928-13897-1-git-send-email-santosh.shilimkar@ti.com>
 <20131002170917.GB30298@mudshark.cambridge.arm.com> <524C5484.5000601@ti.com>
 <524C565C.8010709@codeaurora.org> <524C5786.2090008@ti.com>
 <524C5B10.20006@codeaurora.org>
 <20131002174841.GH30298@mudshark.cambridge.arm.com> <524C60F4.7000802@ti.com>
Message-ID: <5255EDD6.1050401@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/02/2013 11:07 AM, Santosh Shilimkar wrote:
> On Wednesday 02 October 2013 01:48 PM, Will Deacon wrote:
>> On Wed, Oct 02, 2013 at 06:42:40PM +0100, Stephen Boyd wrote:
>>> On 10/02/13 10:27, Santosh Shilimkar wrote:
>>>> Really... I have not created patch out of fun.
>>>> Its broken on my keystone machine at least where the sched_clock is
>>>> falling back on jiffy based sched_clock even in presence of arch_timer
>>>> sched_clock.
>>> How is that possible? sched_clock_func is only assigned by
>>> arch/arm/kernel/arch_timer.c when the architected timer is detected and
>>> sched_clock() in kernel/time/sched_clock.c calls that function pointer
>>> unconditionally. The only way I see this happening is if the architected
>>> timer rate is zero.
>>   ^^^^^^^^^^^^^^^^^^
>>
>> *cough* CNTFRQ *cough*
>>
> :) CNTFRQ as such is fine. I think the below print mis-lead me mostly. 
>
> sched_clock: ARM arch timer >56 bits at 6144kHz, resolution 162ns
> sched_clock: 32 bits at 100 Hz, resolution 10000000ns, wraps every 4294967286ms
>
> So yes, now the subject patch actually just avoids the jiffy sched_clock()
> registration and nothing else. Even without the patch arch_timer sched_clock
> will be in use.

Just wanted to follow up here, as I've not been paying close attention.
Is this issue then resolved, or is something still needed to be queued
for 3.12/3.13?

thanks
-john
