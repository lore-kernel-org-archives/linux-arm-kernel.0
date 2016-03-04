From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Fri, 4 Mar 2016 10:20:56 +0000
Subject: [PATCH v2 2/5] arm64: add ARMv8.2 id_aa64mmfr2 boiler plate
In-Reply-To: <20160303191920.GA650@arm.com>
References: <1454684330-892-1-git-send-email-james.morse@arm.com>
 <1454684330-892-3-git-send-email-james.morse@arm.com>
 <56D87B74.1010306@codeaurora.org> <56D88219.6040806@arm.com>
 <56D88A6C.8070304@codeaurora.org> <20160303191920.GA650@arm.com>
Message-ID: <56D96188.4080203@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/03/16 19:19, Will Deacon wrote:
> On Thu, Mar 03, 2016 at 02:03:08PM -0500, Christopher Covington wrote:
>> On 03/03/2016 01:27 PM, Robin Murphy wrote:
>>> On 03/03/16 17:59, Christopher Covington wrote:
>>

>>>> swapper[0]: undefined instruction: pc=ffffff800808d730
>>>> Code: d5380702 d5380721 f9017c02 f9018001 (d5380742)
>>>> Internal error: Oops - undefined instruction: 0 [#1] PREEMPT SMP
>>>> Modules linked in:
>>>> CPU: 0 PID: 0 Comm: swapper Not tainted 4.5.0-rc6-next-20160303 #1
>>>> Hardware name: (null) (DT)
>>>> task: ffffff8008b2d980 ti: ffffff8008b20000 task.ti: ffffff8008b20000
>>>> PC is at __cpuinfo_store_cpu+0x68/0x198
>>>> LR is at cpuinfo_store_boot_cpu+0x28/0x50
>>>>
>>>> ffffff800808d730:       d5380742        mrs     x2, s3_0_c0_c7_2
>>>
>>> Hmm, per table C5-6 in the ARMv8 ARM (issue i), that's specifically a
>>> reserved encoding, rather than an unallocated one, so it should read as
>>> zero, not undef. What are you running on?
>>
>> QDF2432. I'll investigate.
>
> FWIW, I think the same issue was reported on qemu, so we may want to
> handle this in the kernel anyway. We could either use alternatives on
> the register read or handle the undef.

We could use parts of the mrs emulation patch [1] to emulate only the above
for kernel mode.

[1] https://lkml.org/lkml/2015/10/13/641

Cheers
Suzuki
