From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 2 Jul 2015 16:18:20 +0800
Subject: [RFC] arm: psci: implement cpuidle_ops
In-Reply-To: <5594F12F.6050401@linaro.org>
References: <20150702111031.05f04184@xhacker>
	<5594F12F.6050401@linaro.org>
Message-ID: <20150702161820.15dc9770@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Daniel,

On Thu, 2 Jul 2015 10:07:11 +0200
Daniel Lezcano <daniel.lezcano@linaro.org> wrote:

> On 07/02/2015 05:10 AM, Jisheng Zhang wrote:
> > Hi all,
> >
> > we'd like to use cpuidle-arm.c for both arm and arm64 with psci as backend. For
> > arm64, it works. But for arm, we miss cpuidle_ops. I want to add cpuidle_ops for
> > arm psci, I dunno whether this is the correct direction, could you please give
> > suggestions?
> 
> You should look at the macro
> 
> arch/arm/include/asm/cpuidle.h:
> 
> #define CPUIDLE_METHOD_OF_DECLARE(name, _method, _ops)

Yep, this is what I want to use. I want to use this MACRO to implement cpuidle_ops
for arm, but I dunno whether this is the correct direction. And I'd like to
reuse cpu_psci_cpu_init_idle() function in arch/arm64/kernel/psci.c to parse
the DT, but I'm not sure where to put cpu_psci_cpu_init_idle() so that can
be shared between arm and arm64. Also I noticed that there's a psci unification
work from Mark Rutland, does it make sense to put it in drivers/firmware/psci.c?

Thanks a lot,
Jisheng
