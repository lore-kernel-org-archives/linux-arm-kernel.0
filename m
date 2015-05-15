From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Fri, 15 May 2015 16:43:01 +0100
Subject: [PATCH v4 03/12] KVM: arm64: guest debug, define API headers
In-Reply-To: <CAFEAcA8ZpndRyT84ta2r4bPTE1uGTN1XTfMpUn8qW022ben3BQ@mail.gmail.com>
References: <1431700035-23479-1-git-send-email-alex.bennee@linaro.org>
 <1431700035-23479-4-git-send-email-alex.bennee@linaro.org>
 <20150515144423.GA23652@leverpostej> <874mndlvny.fsf@linaro.org>
 <CAFEAcA8ZpndRyT84ta2r4bPTE1uGTN1XTfMpUn8qW022ben3BQ@mail.gmail.com>
Message-ID: <871tihlud6.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Peter Maydell <peter.maydell@linaro.org> writes:

> On 15 May 2015 at 16:14, Alex Benn?e <alex.bennee@linaro.org> wrote:
>>
>> Mark Rutland <mark.rutland@arm.com> writes:
>>
>>> On Fri, May 15, 2015 at 03:27:06PM +0100, Alex Benn?e wrote:
>>>> +/*
>>>> + * See v8 ARM ARM D7.3: Debug Registers
>>>> + *
>>>> + * The control registers are architecturally defined as 32 bits but are
>>>> + * stored as 64 bit values alongside the value registers. This is done
>>>
>>> Stale comment? They're stored as __u32 below.
>>
>> Gah yes it is.
>>
>>> It's possible that the registers could grow in future as happened in the
>>> case of CLIDR_EL1, so it might be worth treating system registers
>>> generally as u64 values.
>>
>> Really? I mean the existing debug *control* registers have reserved bits
>> 24-31 so there is space for expansion.
>
> Other places in the userspace ABI which deal with sysregs (notably
> ONE_REG) consistently define them all as 64-bit (which makes sense
> anyway since the ISA only provides 64-bit accessors to them).
> "Architecturally 32 bits" only means "top 32 bits reserved".

Fair enough, I can switch it back. The main reason I had them as all 64
bit before was because of the mapping onto the sys_regs context. If
everyone is happy bloating the ABI a little I'm OK with that. It will
make the hyp.S macro a little less ugly for one.

>
> -- PMM

-- 
Alex Benn?e
