From: dave.long@linaro.org (David Long)
Date: Wed, 22 Jun 2016 14:28:25 -0400
Subject: [PATCH v13 05/10] arm64: Kprobes with single stepping support
In-Reply-To: <20160614094559.51a7865fa30f3f31f6a70e37@kernel.org>
References: <1464924384-15269-1-git-send-email-dave.long@linaro.org>
 <1464924384-15269-6-git-send-email-dave.long@linaro.org>
 <20160608100714.4abbcebcf356eb72173d0ce3@kernel.org>
 <575E3235.1020904@linaro.org>
 <20160613155017.860097875e8bc86563a065ce@kernel.org>
 <575ECFC7.10207@linaro.org>
 <20160614094559.51a7865fa30f3f31f6a70e37@kernel.org>
Message-ID: <576AD8C9.7050109@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/13/2016 08:45 PM, Masami Hiramatsu wrote:
> On Mon, 13 Jun 2016 11:22:47 -0400
> David Long <dave.long@linaro.org> wrote:
>
>> On 06/13/2016 02:50 AM, Masami Hiramatsu wrote:
>>> On Mon, 13 Jun 2016 00:10:29 -0400
>>> David Long <dave.long@linaro.org> wrote:
>>>
>>>>>> ---
>>>>>>     arch/arm64/Kconfig                      |   1 +
>>>>>>     arch/arm64/include/asm/debug-monitors.h |   5 +
>>>>>>     arch/arm64/include/asm/insn.h           |   4 +-
>>>>>>     arch/arm64/include/asm/kprobes.h        |  60 ++++
>>>>>>     arch/arm64/include/asm/probes.h         |  44 +++
>>>>>>     arch/arm64/kernel/Makefile              |   1 +
>>>>>>     arch/arm64/kernel/debug-monitors.c      |  18 +-
>>>>>>     arch/arm64/kernel/kprobes-arm64.c       | 144 +++++++++
>>>>>>     arch/arm64/kernel/kprobes-arm64.h       |  35 +++
>>>>>>     arch/arm64/kernel/kprobes.c             | 526 ++++++++++++++++++++++++++++++++
>>>>>
>>>>> Not sure why kprobes.c and kprobes-arm64.c are splitted.
>>>>>
>>>>>
>>>>
>>>> This comes from the model of the arm32 kprobes code where handling of
>>>> the low-level instruction simulation is implemented in separate files
>>>> for 32-bit vs. thumb instructions.  It should make a little more sense
>>>> in the future when additional instruction simulation code will hopefully
>>>> be added for those instructions we cannot currently single-step
>>>> out-of-line.  It also probably *could* be merged into one file.
>>>
>>> Hmm, at least the name of arch/arm64/kernel/kprobes-arm64.c is
>>> meaningless. As we've done in x86, I think we can make it
>>> arch/arm64/kernel/kprobes/decode-insn.{c,h}
>>>
>>
>> I've changed the name to kprobe-decode-insn.[hc], or do you feel
>> strongly the three kprobes source files in arch/arm64/kernel need their
>> own subdirectory?
>
> Yes, especially when we start working on kprobes-on-ftrace support,
> it is better to have a separate file for that.
>

I've reorganized the kprobes source files into their own subdirectory 
and changed some of their names.

> Thank you!
>
>

Thanks,
-dl
