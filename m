From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Mon, 11 Nov 2013 16:53:32 +0900
Subject: [PATCH RFC 4/6] arm64: Add kernel return probes
 support(kretprobes)
In-Reply-To: <CA+b37P2aeXs4Cy_HxF24HQAYAnYzZ19PgV6rqrQLY9SMpZHDJg@mail.gmail.com>
References: <1382008671-4515-1-git-send-email-sandeepa.prabhu@linaro.org>
 <1382008671-4515-5-git-send-email-sandeepa.prabhu@linaro.org>
 <20131108170448.GF15074@mudshark.cambridge.arm.com>
 <CA+b37P2aeXs4Cy_HxF24HQAYAnYzZ19PgV6rqrQLY9SMpZHDJg@mail.gmail.com>
Message-ID: <52808CFC.6060701@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/11/2013 01:29 PM, Sandeepa Prabhu wrote:
> On 8 November 2013 22:34, Will Deacon <will.deacon@arm.com> wrote:
>>> +static inline long regs_return_value(struct pt_regs *regs)
>>> +{
>>> +     return regs->regs[0];
>>> +}
>>
>> This is also being implemented by another patch series (I think the audit
>> stuff?).
> Not sure, I did not see this being implemented in audit(audit adds for
> 'syscallno',  not for return value in x0)
> I can rebase my code if this change is implemented and queued in other patchset.

Yes, my audit patch has it.
The definition is referred to in include/linux/audit.h (and ptrace.h),
too.

-Takahiro AKASHI
