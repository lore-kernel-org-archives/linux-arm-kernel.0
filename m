From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 22 Sep 2016 09:58:52 +0100
Subject: [PATCH v2] drivers: psci: PSCI checker module
In-Reply-To: <7hfuothzff.fsf@baylibre.com>
References: <20160921143905.36197-1-kevin.brodsky@arm.com>
 <7hfuothzff.fsf@baylibre.com>
Message-ID: <20160922085852.GA18637@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 21, 2016 at 11:37:24AM -0700, Kevin Hilman wrote:
> Kevin Brodsky <kevin.brodsky@arm.com> writes:
> 
> > On arm and arm64, PSCI is one of the possible firmware interfaces
> > used for power management. This includes both turning CPUs on and off,
> > and suspending them (entering idle states).
> >
> > This patch adds a PSCI checker module that enables basic testing of
> > PSCI operations during startup. There are two main tests: CPU
> > hotplugging and suspending.
> >
> > In the hotplug tests, the hotplug API is used to turn off and on again
> > all CPUs in the system, and then all CPUs in each cluster, checking
> > the consistency of the return codes.
> >
> > In the suspend tests, a high-priority thread is created on each core
> > and uses low-level cpuidle functionalities to enter suspend, in all
> > the possible states and multiple times. This should allow a maximum
> > number of CPUs to enter the same sleep state at the same or slightly
> > different time.
> 
> Since you're doing it multiple times, it might be useful to track the
> actual time it takes to suspend and wakeup, and possibly even warn
> if the time is longer than the target_residency.  This could catch
> poorly configured idle states.

That's a good point, we can add a couple of checks for latencies on top
of the existing code, we will definitely do, at the moment we are
concerned with the overall design in particular in relation to usage of
high priority threads and tick broadcast to test the PSCI suspend
interface.

Thank you for having a look !

Lorenzo
