From: vichy.kuo@gmail.com (vichy)
Date: Mon, 27 Oct 2014 21:32:52 +0800
Subject: where/how arm start first jump from svc to user in kernel
In-Reply-To: <20141021161555.GG15293@leverpostej>
References: <CAOVJa8Ho8Qz847HipcESsu=tDmd77r=hj4TP3Ut-4DG5nyQosw@mail.gmail.com>
 <20141015162005.GF22949@e104818-lin.cambridge.arm.com>
 <CAOVJa8Fa25W=oNHridmq+zZCRWRgKZtH+Ykt=w_YSwcaqpaNhA@mail.gmail.com>
 <20141021124132.GE15293@leverpostej>
 <CAOVJa8Eg37q8Mkrs1epraRnwUwSV0MO0p74727gCsdaaDwgoWg@mail.gmail.com>
 <20141021161555.GG15293@leverpostej>
Message-ID: <CAOVJa8HbSR82RBHVh8Dj=3=R81b+0wtsdfj4d7QvaRgxbOjeww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Mark and all:

> In Linux we use move pc, lr on ARMv7 for dropping from PL1 to PL0. If
> that's run on ARMv8, it's no different.
>
> On ARMv8, 32-bit software runnign at EL3 (which would be in PL1) could
> use eret, or could use MOVS PC, LR.
>From your explanation, it seems no matter EL3/EL2/EL1 in
ARMv8+aarch32, we both can use "eret" or "MOVS PC, LR" return back to
lower privilege level.
BTW, Could we get the conclusion that ARMv7 = ARMv8 +aarch32?
>
>> > extensions (and in PL1 behaves as movs pc, lr if present). So it's
>> Is here a type? (PL1 should be EL1?)
>
> Not a typo. While ARMv8 defines things in terms of Exception Levels,
> ARMv7 defined things in terms of Privilege Levels, and this is carried
> over to AArch32 in ARMv8.
>
> The mapping of Privilege Levels to Exception Levels is dependent on
> several factors. The ARMv8 ARM ARM describes the two in more detail in
> "Execution privilege, Exception levels, and AArch32 Privilege levels".
Below is excerpted from the section you mentioned.

System, FIQ, IRQ, Supervisor, Abort, and Undefined modes are implemented:
In Secure state  If either:
? EL3 is using AArch32.
? EL3 is using AArch64 and EL1 is using AArch32.

How could we mixed AArch32/AArch64 in different Exception level?
in ARMv8, aarch32/aarch64 could switch each other without any
restriction by only setting up M[4], bit [4] in SPSR when return?

appreciate your kind help, ^^
