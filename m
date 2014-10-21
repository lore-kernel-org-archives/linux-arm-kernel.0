From: vichy.kuo@gmail.com (vichy)
Date: Tue, 21 Oct 2014 21:49:18 +0800
Subject: where/how arm start first jump from svc to user in kernel
In-Reply-To: <20141021124132.GE15293@leverpostej>
References: <CAOVJa8Ho8Qz847HipcESsu=tDmd77r=hj4TP3Ut-4DG5nyQosw@mail.gmail.com>
 <20141015162005.GF22949@e104818-lin.cambridge.arm.com>
 <CAOVJa8Fa25W=oNHridmq+zZCRWRgKZtH+Ykt=w_YSwcaqpaNhA@mail.gmail.com>
 <20141021124132.GE15293@leverpostej>
Message-ID: <CAOVJa8Eg37q8Mkrs1epraRnwUwSV0MO0p74727gCsdaaDwgoWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 hi Mark:
2014-10-21 20:41 GMT+08:00 Mark Rutland <mark.rutland@arm.com>:
> There is no movs pc, lr equivalent in AArch64. The eret instruction is
> the only mechanism for dropping to a lower privileged exception level
> (e.g. to EL0 userspace from an EL1 kernel).
>
> The A32 eret instruction was only added with the ARMv7 virtualization
Per your explanation, EL0/EL1/EL3 of A32 are still using movs pc, lr, right?
> extensions (and in PL1 behaves as movs pc, lr if present). So it's
Is here a type? (PL1 should be EL1?)

> necessary to us movs pc, lr to function across a wide variety of CPUs,
> and there's no benefit to using eret.
thanks for your kind help,
