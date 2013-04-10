From: hechtb@gmail.com (Bastian Hecht)
Date: Wed, 10 Apr 2013 14:11:16 +0200
Subject: [PATCH] ARM: hw_breakpoint: Do not use __cpuinitdata for
 dbg_cpu_pm_nb
In-Reply-To: <5165554D.3040107@arm.com>
References: <1365588278-5185-1-git-send-email-hechtb+renesas@gmail.com>
 <20130410111148.GA26992@mudshark.cambridge.arm.com>
 <CABYn4szw=kE_DD1eNZ-CsM__o_cJUA5+F4M8T5-Uyf_nw+bfGg@mail.gmail.com>
 <5165554D.3040107@arm.com>
Message-ID: <CABYn4szX3k2m-BZRTH3xKGChHGu212cHnEAoYakbctHOia+ibA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dietmar,

2013/4/10 Dietmar Eggemann <dietmar.eggemann@arm.com>:
> On 10/04/13 12:26, Bastian Hecht wrote:
>>
>> 2013/4/10 Will Deacon <will.deacon@arm.com>:
>>>
>>> On Wed, Apr 10, 2013 at 11:04:38AM +0100, Bastian Hecht wrote:
>>>>
>>>> We must not declare dbg_cpu_pm_nb as __cpuinitdata as we need it after
>>>> system initialization for Suspend and CPUIdle.
>>>>
>>>> This was done in commit 9a6eb310eaa5336b89a27a0bbb78da4bba35f6f1
>>>> ARM: hw_breakpoint: Debug powerdown support for self-hosted debug
>>>>
>>>> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
>>>
>>>
>>> Thanks Bastian, I'll take this into my tree.
>>>
>>> Will
>>
>>
>> Nice, thanks!
>>
>
> Hi Bastian,
>
> thanks for catching this. Is my assumption right that you used an UP kernel?

Yes exactly, it's for a Cortex A9 UP core, so a UP kernel. Glad I could help.

> I didn't catch this error during my Suspend-To-Ram/CPUidle tests because
> I tested only on SMP kernels where 'dbg_cpu_pm_nb' is placed into the
> .data and not in the .init.data section.
>
>
> Will, we have the same issue in arch/arm/kernel/perf_event_cpu.c.
> Lorenzo is currently working on an appropriate patch.
>
> -- Dietmar
>
> -- IMPORTANT NOTICE: The contents of this email and any attachments are
> confidential and may also be privileged. If you are not the intended
> recipient, please notify the sender immediately and do not disclose the
> contents to any other person, use it for any purpose, or store or copy the
> information in any medium.  Thank you.
>
