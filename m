From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 7 Jan 2016 15:58:15 +0000
Subject: [Qemu-devel] arm64 qemu tests failing in linux-next since 'arm64:
 kernel: enforce pmuserenr_el0 initialization and restore'
In-Reply-To: <20160107155310.GA4064@red-moon>
References: <567B41E3.5060800@roeck-us.net>
 <CAFEAcA_c9DicGF+is6ST3NJv+c5Bi4dHYo2t8Q2n9AS9G4q0+Q@mail.gmail.com>
 <20160107155310.GA4064@red-moon>
Message-ID: <CAFEAcA_vP93=PE6LNNHodCsdk0gL0kBQPX=xzLJU5RzkvNs2vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 January 2016 at 15:53, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> On Thu, Jan 07, 2016 at 01:25:35PM +0000, Peter Maydell wrote:
>> We had previously been relying on the kernel not attempting to
>> touch the PMU if the ID_AA64DFR0_EL1 PMUVer bits read 0000
>> ("Performance Monitors extension System registers not implemented").
>
> Ok, thanks for looking into this. I wonder why reading pmcr_el0 does
> not suffer from the same problem though.

Just a pragmatic thing on QEMU's end, I expect -- the kernel already
touched PMCR_EL0 and we wanted to be able to boot it, so we have an
implementation of it.

thanks
-- PMM
