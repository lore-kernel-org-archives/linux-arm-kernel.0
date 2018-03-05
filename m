From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 5 Mar 2018 17:08:25 +0000
Subject: [RFC PATCH] arm64: kaslr: Set TCR_EL1.NFD1 when
 CONFIG_RANDOMIZE_BASE=y
In-Reply-To: <20180305102656.GC8571@arm.com>
References: <1520244528-9649-1-git-send-email-will.deacon@arm.com>
 <CAKv+Gu_k6Dat=5oo3gYLR0E19YfDSjTFYs2vfzqBdx55rm4oFA@mail.gmail.com>
 <20180305102656.GC8571@arm.com>
Message-ID: <CAKv+Gu_ru++VyqX0-EQDX5Bh6pnrUMc0dzp8cFjBD8hZxoCHSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 March 2018 at 10:26, Will Deacon <will.deacon@arm.com> wrote:
> On Mon, Mar 05, 2018 at 10:15:29AM +0000, Ard Biesheuvel wrote:
>> On 5 March 2018 at 10:08, Will Deacon <will.deacon@arm.com> wrote:
>> > TCR_EL1.NFD1 was allocated by SVE and ensures that fault-surpressing SVE
>> > memory accesses (e.g. speculative accesses from a first-fault gather load)
>> > which translate via TTBR1_EL1 result in a translation fault if they
>> > miss in the TLB when executed from EL0. This mitigates some timing attacks
>> > against KASLR, where the kernel address space could otherwise be probed
>> > efficiently using the FFR in conjunction with suppressed faults on SVE
>> > loads.
>> >
>> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> > Cc: Dave Martin <Dave.Martin@arm.com>
>> > Signed-off-by: Will Deacon <will.deacon@arm.com>
>> > ---
>> >
>> > Sending as RFC because this doesn't make any difference if kpti is enabled,
>> > which is the default with KASLR. It helps if kpti=off is being passed and
>> > shouldn't have an impact on performance.
>> >
>>
>> This just makes it harder/slower to probe the kernel address space
>> using SVE instructions, right?
>
> Yeah, basically, but given that kpti should make any walks via ttbr1 from
> EL0 timing invariant, it doesn't make a whole lot of difference in
> conjunction with that.
>

Seems sane in any case

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
