From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 2 Jul 2015 16:32:53 +0100
Subject: [RFC] arm: psci: implement cpuidle_ops
In-Reply-To: <20150702161820.15dc9770@xhacker>
References: <20150702111031.05f04184@xhacker> <5594F12F.6050401@linaro.org>
 <20150702161820.15dc9770@xhacker>
Message-ID: <20150702153253.GB14244@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 02, 2015 at 09:18:20AM +0100, Jisheng Zhang wrote:
> Dear Daniel,
> 
> On Thu, 2 Jul 2015 10:07:11 +0200
> Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> 
> > On 07/02/2015 05:10 AM, Jisheng Zhang wrote:
> > > Hi all,
> > >
> > > we'd like to use cpuidle-arm.c for both arm and arm64 with psci as backend. For
> > > arm64, it works. But for arm, we miss cpuidle_ops. I want to add cpuidle_ops for
> > > arm psci, I dunno whether this is the correct direction, could you please give
> > > suggestions?
> > 
> > You should look at the macro
> > 
> > arch/arm/include/asm/cpuidle.h:
> > 
> > #define CPUIDLE_METHOD_OF_DECLARE(name, _method, _ops)
> 
> Yep, this is what I want to use. I want to use this MACRO to implement cpuidle_ops
> for arm, but I dunno whether this is the correct direction. And I'd like to
> reuse cpu_psci_cpu_init_idle() function in arch/arm64/kernel/psci.c to parse
> the DT, but I'm not sure where to put cpu_psci_cpu_init_idle() so that can
> be shared between arm and arm64. Also I noticed that there's a psci unification
> work from Mark Rutland, does it make sense to put it in drivers/firmware/psci.c?

I think cpu_psci_cpu_init_idle() should live in drivers/firmware/psci.c.
I also think that Lorenzo had an idea as to what should be done
regarding unifying the arm and arm64 approaches, but he's currently away
and I'm not all that familiar with cpuidle.

Thanks,
Mark.
