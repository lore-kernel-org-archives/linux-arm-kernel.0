From: srinidhi.kasagar@stericsson.com (Srinidhi Kasagar)
Date: Wed, 13 Jun 2012 17:13:27 +0530
Subject: Fwd: [RFC PATCH 00/15] ARM: perf: support multiple PMUs
In-Reply-To: <CAMzctLkwJCrgKoeYET=OYcfOifKuTEWoWfcRgWts4Y6aspZEUA@mail.gmail.com>
References: <4B9A4BAF850C914D8DED94776A2C477E0B853A2F@nasanexd01b.na.qualcomm.com>
 <4E52A852.9090809@codeaurora.org>
 <20110822201546.GD22755@e102144-lin.cambridge.arm.com>
 <CAMzctLkwJCrgKoeYET=OYcfOifKuTEWoWfcRgWts4Y6aspZEUA@mail.gmail.com>
Message-ID: <20120613114326.GA14399@bnru02>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Marc/Will,

[...]

> Subject: [RFC PATCH 00/15] ARM: perf: support multiple PMUs
> ------------------------
> 
> From: Mark Rutland <mark.rutland at arm.com<mailto:mark.rutland@arm.com>>
> Date: Mon, Aug 15, 2011 at 7:12 PM
> To: linux-arm-kernel at lists.infradead.org

[...]

> System (AKA nest or uncore) PMUs exist on devices which are not affine
> to a single CPU. They usually cannot be directly associated with
> individual tasks and are asynchronous with respect to the current
> execution. Examples of devices which could have system PMUs include L2
> cache controllers, GPUs and memory buses.
> 
> The following patch series refactors the ARM PMU backend, enabling
> new PMUs to reuse the existing code. This should allow for system PMUs
> to be supported in future. Further work will be required to get perf to
> fully understand system PMUs, but this provides something usable.
> 
> The framework is intended to be used by system PMUs which hang off core
> platform components (e.g. L2 cache, AXI bus). If a device is complex
> enough or separate enough from core functionality to have its own
> driver, it should implement its own PMU handling using the core perf
> API directly.
> 
> The first patch ("perf: provide PMU when initing events") is currently
> sitting in the tip tree, but as it's required for event initialization
> to function (and hence for the PMU to be usable), it's provided here
> for convenience.
> 
> The series is based on Will Deacon's perf-updates branch at:
>        git://linux-arm.org/linux-2.6-wd.git perf-updates
> 
> An example driver using the framework (supporting the PMU present in
> L220/PL310 level 2 cache controllers) can be found at:
>        git://linux-arm.org/linux-2.6-wd.git perf-l2x0-wip
> 
Do you still maintain this tree? Looks it is empty. I'm wondering if
we can make use of this to instrument the PMU counters of L2/pl310.

/srinidhi 
