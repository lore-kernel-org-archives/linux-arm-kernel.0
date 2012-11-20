From: rusty@rustcorp.com.au (Rusty Russell)
Date: Tue, 20 Nov 2012 12:48:55 +1030
Subject: [kvmarm] [PATCH v4 09/14] KVM: ARM: Emulation framework and CP15
 emulation
In-Reply-To: <CAFEAcA_6DZ-rZu-hDJfKJBW7epVyuukPd042Ny1rOxuRF4hAVQ@mail.gmail.com>
References: <20121110154203.2836.46686.stgit@chazy-air>
 <20121110154313.2836.2851.stgit@chazy-air>
 <20121119150105.GB3205@mudshark.cambridge.arm.com>
 <CAFEAcA_6DZ-rZu-hDJfKJBW7epVyuukPd042Ny1rOxuRF4hAVQ@mail.gmail.com>
Message-ID: <87k3thow34.fsf@rustcorp.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter Maydell <peter.maydell@linaro.org> writes:
> On 19 November 2012 15:01, Will Deacon <will.deacon@arm.com> wrote:
>> On Sat, Nov 10, 2012 at 03:43:13PM +0000, Christoffer Dall wrote:
>>> +/*
>>> + * A15-specific CP15 registers.
>>> + * Important: Must be sorted ascending by CRn, CRM, Op1, Op2
>>> + */
>>> +static const struct coproc_reg a15_regs[] = {
>>> +       /* MPIDR: we use VMPIDR for guest access. */
>>> +       { CRn( 0), CRm( 0), Op1( 0), Op2( 5), is32,
>>> +                       NULL, reset_mpidr, c0_MPIDR },
>>> +
>>> +       /* SCTLR: swapped by interrupt.S. */
>>> +       { CRn( 1), CRm( 0), Op1( 0), Op2( 0), is32,
>>> +                       NULL, reset_val, c1_SCTLR, 0x00C50078 },
>>
>> Why is the SCTLR included here as an A15-specific register?
>
> Rusty might remember the exact answer, but probably because
> the SCTLR reset value is IMPDEF.

Indeed...

Cheers,
Rusty.
