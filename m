From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 8 Apr 2011 20:10:04 +0200
Subject: [RFC] Extending ARM perf-events for multiple PMUs
In-Reply-To: <1302282912.5758.25.camel@e102144-lin.cambridge.arm.com>
References: <1302282912.5758.25.camel@e102144-lin.cambridge.arm.com>
Message-ID: <BANLkTinAcAudWKvipYVLyijUrLZVFozBWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will, thanks for this quite informative letter!

On Fri, Apr 8, 2011 at 7:15 PM, Will Deacon <will.deacon@arm.com> wrote:

> Implementing support for Counting System PMUs can reuse a lot of the
> functionality in perf_event.c (for example, struct arm_pmu) but the low-level
> accessors should be separate and a new struct pmu should be used. This means
> that we will want multiple instances of struct arm_pmu and a method to translate
> from a struct pmu to a struct arm_pmu. We'll also need to clean up some of the
> armpmu_* functions to ensure the correction indirection is used when invoking
> per-pmu functions.

What I start wondering at this point in the description is that there is some
implicit assumption that counting system PMU:s is an arch/arm/* thing,
that they should even be named arm_* and I guess as such they are
some PrimeCell kind of thing.

I can surely accept the per-CPU close-to-CPU counters to live
in arch/arm/* but..

I am thinking that a SoC vendor like Renesas may be implementing a
System PMU monitoring a bus shared between an SH and and ARM
core.

Unless you're ARM Ltd you can also think about vendors doing System
PMU IP blocks and synthesizing these in both ARM and other-arch
systems.

So maybe this needs an multiarch-spanning solution? I start
thinking about decoupling these babies from the arch and abstracting
them into something like drivers/perf

Am I totally misguided in this?

Yours,
Linus Walleij
