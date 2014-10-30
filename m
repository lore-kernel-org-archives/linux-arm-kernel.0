From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 30 Oct 2014 11:55:22 +0000
Subject: [PATCH 1/1] bus: cci: move away from arm_pmu framework
In-Reply-To: <9hhzjcfeyza.fsf@arm.com>
References: <1413826531-23462-1-git-send-email-mark.rutland@arm.com>
 <1413826531-23462-2-git-send-email-mark.rutland@arm.com>
 <9hhzjcfeyza.fsf@arm.com>
Message-ID: <20141030115521.GC32495@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 29, 2014 at 02:23:37PM +0000, Punit Agrawal wrote:
> Hi Mark,
> 
> Mark Rutland <mark.rutland@arm.com> writes:
> 
> > The ARM CPU PMUs and the ARM CCI PMU are using the same framework
> > despite being substantially different in programming model, which makes
> > it difficult to handle either particularly well.
> >
> > This patch migrates the ARM CCI PMU driver away from the arm_pmu
> > framework, matching the style of the CCN PMU driver and other 'uncore'
> > PMU drivers. This enables better support for the CCI PMU (including
> > migration of events across CPUs across hotplug) and will allow for
> > refactoring of the arm_pmu framework to better support CPU PMUs.
> >
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Punit Agrawal <punit.agrawal@arm.com>
> 
> Looks good!
> 
> Acked-by: Punit Agrawal <punit.agrawal@arm.com>

Thanks Punit.

Due to a known race [1] in the perf code which we haven't solved yet
I've hacked out the event migration for now. Hopefully we can address
that soon, but there's no reason for that to hold up the arm_pmu rework.

Thanks,
Mark.

[1] https://lkml.org/lkml/2014/9/1/569
