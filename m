From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 7 Jan 2016 16:56:27 +0000
Subject: [Qemu-devel] arm64 qemu tests failing in linux-next since 'arm64:
 kernel: enforce pmuserenr_el0 initialization and restore'
In-Reply-To: <20160107163722.GB4064@red-moon>
References: <567B41E3.5060800@roeck-us.net>
 <CAFEAcA_c9DicGF+is6ST3NJv+c5Bi4dHYo2t8Q2n9AS9G4q0+Q@mail.gmail.com>
 <20160107155310.GA4064@red-moon>
 <CAFEAcA_vP93=PE6LNNHodCsdk0gL0kBQPX=xzLJU5RzkvNs2vw@mail.gmail.com>
 <20160107163722.GB4064@red-moon>
Message-ID: <CAFEAcA9D58-EOh9aoAmFtEBBx=BWQxWyzynvM893Dd7fqZH5wA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 January 2016 at 16:37, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> On Thu, Jan 07, 2016 at 03:58:15PM +0000, Peter Maydell wrote:
>> On 7 January 2016 at 15:53, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
>> > Ok, thanks for looking into this. I wonder why reading pmcr_el0 does
>> > not suffer from the same problem though.
>>
>> Just a pragmatic thing on QEMU's end, I expect -- the kernel already
>> touched PMCR_EL0 and we wanted to be able to boot it, so we have an
>> implementation of it.
>
> If that's the case, that was the wrong approach IMHO. QEMU has to comply
> with the Aarch64 architecture which means that either the CPU it models
> has a Performance Monitors extension or it does not. If reading pmcr_el0
> does not fault I could tell you this is a QEMU regression because currently
> it _does_ model pmcr_el0 while (hopefully) ID_AA64DFR0_EL1 PMUVer reports
> it should not.

I agree it's a bug, but QEMU simply doesn't have enough
developers to become fully compliant with the architecture (ie to
implement every part of it completely). So we concentrate on the
parts that people are actually using, and fill in the rest and
fix the bugs as time permits or as real guest software starts to
use it.

If you want a guaranteed matches-the-architecture software model
of an ARM CPU then other models are available :-)

thanks
-- PMM
