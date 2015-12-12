From: dave.long@linaro.org (David Long)
Date: Sat, 12 Dec 2015 00:56:14 -0500
Subject: [RFC] kprobe'ing conditionally executed instructions
In-Reply-To: <566AF556.6050704@redhat.com>
References: <566A5997.9020908@linaro.org> <566AF556.6050704@redhat.com>
Message-ID: <566BB6FE.2050005@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/11/2015 11:09 AM, William Cohen wrote:
> On 12/11/2015 12:05 AM, David Long wrote:
>> There is a moderate amount of code already in kprobes on ARM and the current ARMv8 patch to deal with conditional execution of instructions. One aspect of how this is handled is that instructions that fail their predicate and are not (technically) executed are also not treated as a hit kprobe. Steve Capper has suggested that the probe handling should still take place because we stepped through the instruction even if it was effectively a nop.  This would be a significant change in how it currently works on 32-bit ARM, and a change in the patch for ARMv8 (although it's not likely to be much of a change in the kernel code).
>>
>> I need input on this.  Do people have opinions?
>>
>> -dl
>>
>
> Hi Dave,
>
> Conditionally executing the kprobes would violate the assumptions made for perf and systemtap collecting data. Even if the instruction is predicated and treated as a NOP it should still reliably trigger the kprobe.  However, for efficiency the simulation/emulation/single-step of the instruction could be skipped if the instruction is known to have no change on the machine state other than changing the program counter.
>
> -Will Cohen
>

I wonder if this might explain some systemtap failures.

-dl
