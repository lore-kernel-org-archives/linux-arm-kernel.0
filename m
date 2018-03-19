From: ndesaulniers@google.com (Nick Desaulniers)
Date: Mon, 19 Mar 2018 17:42:49 +0000
Subject: arm64 kvm built with clang doesn't boot
In-Reply-To: <38b3c636-38cd-2cc5-79d0-8ccf234e2b26@arm.com>
References: <CAAeHK+xjnXnrG0p06r-QRcUucYi5vcTJOn3mSS-JVxX9_TYg4w@mail.gmail.com>
 <26a25069-ea1d-5fb3-549c-ab653f454a30@arm.com>
 <CAAeHK+zq4-mw3pCNf3nob3gN-s+aWVq7vUy1p8yY4bU4QYNNMg@mail.gmail.com>
 <2e84a842-96e8-aec4-8b85-9ee879bb323a@arm.com>
 <CAKwvOd=-TeLJn9=V_Dmj-X+qcRBcfH8tcktbm33xAx671VCYUw@mail.gmail.com>
 <38b3c636-38cd-2cc5-79d0-8ccf234e2b26@arm.com>
Message-ID: <CAKwvOdkypCE2YEmOLxmst1Xtosc+FmNQ7LU=p94b5xkn-4=fVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The thread I was thinking of is:
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-March/562953.html
which is about b092201e0020614127f495c092e0a12d26a2116e `arm64: Add
ARM_SMCCC_ARCH_WORKAROUND_1 BP hardening support`.  As you mention, that
commit uses the correct widths.
Andrey had sent me his workaround, which modified some #defines in
include/linux/arm-smccc.h, which were added recently in commit
f2d3b2e8759a5833df6f022e42df2d581e6d843c `arm/arm64: smccc: Implement SMCCC
v1.1 inline primitive`.

>>> We probably want to be very explicit with register widths here.

So f2d3b2e8759 is the patch I'm referring to.

On Fri, Mar 16, 2018 at 10:18 AM Marc Zyngier <marc.zyngier@arm.com> wrote:

> On 16/03/18 16:52, Nick Desaulniers wrote:

> [dropping kernel-dynamic-tools at google.com which keeps bouncing]

> > Is this in regards to: commit "arm64: Add ARM_SMCCC_ARCH_WORKAROUND_1 BP
> > hardening support"? Has anyone tried to upstream a fix for this?  We
> > probably want to be very explicit with register widths here.
> What do you mean? The current code is as strict as it gets, and
> explicitly tells the compiler to use the right register width, based on
> the SMC call parameter types.

> Thanks,

>          M.
> --
> Jazz is not dead. It just smells funny...



--
Thanks,
~Nick Desaulniers
