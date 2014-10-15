From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 15 Oct 2014 15:07:59 +0100
Subject: [PATCH] arm64: dts: exynos7: add support for cpuidle core power
 down
In-Reply-To: <20141015130218.GB20034@leverpostej>
References: <1413354920-20165-1-git-send-email-k.chander@samsung.com>
 <20141015090047.GA26484@red-moon>
 <20141015130218.GB20034@leverpostej>
Message-ID: <20141015140759.GB26484@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 15, 2014 at 02:02:18PM +0100, Mark Rutland wrote:
> > > +			CPU_SLEEP: cpu-sleep {
> > > +				compatible = "arm,idle-state";
> > > +				local-timer-stop;
> > > +				arm,psci-suspend-param = <0x0010000>;
> > > +				entry-latency-us = <20>;
> > > +				exit-latency-us = <150>;
> > > +				min-residency-us = <2100>;
> > > +				status = "enabled";
> 
> While status is a relatively standard property, it's absence implies
> everything is OK. There no need for it here as-is.
> 
> Additionally, the canonical value is "okay", not "enabled", so this
> would fail were we to use of_device_is_available in the idle states
> parsing.

Good point. I still want it documented in the bindings, keeping in mind
your remark above.

> > status ? This is not a documented property. If you need it please explain
> > why, define its bindings and we can see how to accommodate it.
> 
> Do we expect that some idle states won't be available on some boards
> built from the same platform?

I think it is something we should expect and be able to cope with that.

I will add status to idle-states bindings updates for this cycle and patch DT
parsing code accordingly.

Lorenzo
