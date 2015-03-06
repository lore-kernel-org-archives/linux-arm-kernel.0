From: dave.long@linaro.org (David Long)
Date: Fri, 06 Mar 2015 09:42:59 -0500
Subject: [PATCH v5 4/6] arm64: kprobes instruction simulation support
In-Reply-To: <CAPvkgC1Af0ox8cujTyd0bCYWvJVqyXh-vsRZJ7FG4Zdw1SzEmg@mail.gmail.com>
References: <1424214701-4899-1-git-send-email-dave.long@linaro.org>	<1424214701-4899-5-git-send-email-dave.long@linaro.org>
 <CAPvkgC1Af0ox8cujTyd0bCYWvJVqyXh-vsRZJ7FG4Zdw1SzEmg@mail.gmail.com>
Message-ID: <54F9BCF3.1060609@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/06/15 06:39, Steve Capper wrote:
> On 17 February 2015 at 23:11, David Long <dave.long@linaro.org> wrote:
>> From: Sandeepa Prabhu <sandeepa.prabhu@linaro.org>
>>
>> Kprobes needs simulation of instructions that cannot be stepped
>> from different memory location, e.g.: those instructions
>> that uses PC-relative addressing. In simulation, the behaviour
>> of the instruction is implemented using a copy of pt_regs.
>>
>> Following instruction catagories are simulated:
>>   - All branching instructions(conditional, register, and immediate)
>>   - Literal access instructions(load-literal, adr/adrp)
>>
>> Conditional execution is limited to branching instructions in
>> ARM v8. If conditions at PSTATE do not match the condition fields
>> of opcode, the instruction is effectively NOP. Kprobes considers
>> this case as 'miss'.
>>
>> Thanks to Will Cohen for assorted suggested changes.
>>
>> Signed-off-by: Sandeepa Prabhu <sandeepa.prabhu@linaro.org>
>> Signed-off-by: William Cohen <wcohen@redhat.com>
>> Signed-off-by: David A. Long <dave.long@linaro.org>
>> ---
>
> Hi,
> Apologies for looking at these late (I was on holiday).
>
> I've applied this series on top of 3.19, but I get the following compile error:
> arch/arm64/kernel/kprobes-arm64.c:23:34: fatal error:
> probes-simulate-insn.h: No such file or directory
>   #include "probes-simulate-insn.h"
>                                    ^
> compilation terminated.
> scripts/Makefile.build:257: recipe for target
> 'arch/arm64/kernel/kprobes-arm64.o' failed
>
> Is something missing from this patch?
>
> Cheers,
> --
> Steve
>

Yes Steve, the patch is missing three new files.  It passed my testing 
because I had not cleaned out non-checked-in files from my cloned repo. 
  I've put a preliminary version of a v6 patch that addresses other 
feedback in my own public repo, and will send out a new patch in the 
near future after more testing and additional tweaks.

-dl
