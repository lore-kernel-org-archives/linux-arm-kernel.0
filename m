From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed, 12 Nov 2014 20:06:59 +0900
Subject: [RFC] ptrace: add generic SET_SYSCALL request
In-Reply-To: <20141112110047.GB26437@arm.com>
References: <1415346443-28915-1-git-send-email-takahiro.akashi@linaro.org>
 <20141107140405.GA30156@redhat.com> <54633A69.6090202@linaro.org>
 <20141112110047.GB26437@arm.com>
Message-ID: <54633F53.8020507@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/12/2014 08:00 PM, Will Deacon wrote:
> On Wed, Nov 12, 2014 at 10:46:01AM +0000, AKASHI Takahiro wrote:
>> On 11/07/2014 11:04 PM, Oleg Nesterov wrote:
>>> To me the fact that PTRACE_SET_SYSCALL can be undefined and syscall_set_nr()
>>> is very much arch-dependant (but most probably trivial) means that this  code
>>> should live in arch_ptrace().
>>
>> Thinking of Oleg's comment above, it doesn't make sense neither to define generic
>> NT_SYSTEM_CALL (user_regset) in uapi/linux/elf.h and implement it in ptrace_regset()
>> in kernel/ptrace.c with arch-defined syscall_(g)set_nr().
>>
>> Since we should have the same interface on arm and arm64, we'd better implement
>> ptrace(PTRACE_SET_SYSCALL) locally on arm64 for now (as I originally submitted).
>
> I think the regset approach is cleaner. We already do something similar for
> TLS. That would be implemented under arch/arm64/ with it's own NT type.

Okey, so arm64 goes its own way :)
Or do you want to have a similar regset on arm, too?
(In this case, NT_ARM_SYSTEM_CALL can be shared in uapi/linux/elf.h)

-Takahiro AKASHI

> Will
>
