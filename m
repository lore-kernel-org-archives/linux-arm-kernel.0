From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Wed, 15 Jun 2016 10:27:48 +0100
Subject: Versatile Express randomly fails to boot - Versatile Express to
 be removed from nightly testing
In-Reply-To: <20160614164944.GC1041@n2100.armlinux.org.uk>
References: <20150330140333.GJ24899@n2100.arm.linux.org.uk>
 <55196228.5050805@arm.com> <20150330150552.GK24899@n2100.arm.linux.org.uk>
 <55196E31.80803@arm.com> <551AD902.9090401@arm.com>
 <20150402141336.GI24899@n2100.arm.linux.org.uk> <551D7EAB.1000200@arm.com>
 <1465918285.2840.41.camel@linaro.org>
 <20160614155220.GB1041@n2100.armlinux.org.uk> <5760346A.10903@arm.com>
 <20160614164944.GC1041@n2100.armlinux.org.uk>
Message-ID: <1465982868.2829.20.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-06-14 at 17:49 +0100, Russell King - ARM Linux wrote:
> On Tue, Jun 14, 2016 at 05:44:26PM +0100, Sudeep Holla wrote:
> > Even with higher latency if the platform is unusable, I agree to remove.
> > If you think it's usable with the updated latency(<2 2 1>) then we can
> > update it.
> 
> The kernels I'm booting have that updated latency.  It used to improve
> things, but for most of this year, it fails most boot attempts.  Out
> of the last 21 boot attempts, all 21 attempts failed with the above
> latency value.

I've done some more testing and it seems the different latency values
don't reliably fix things for me after all.

In had previously tried enabling the A9 errata workarounds that aren't
enabled for vexpress:

ARM_ERRATA_751472  Hacked to remove wrong(?) depends !ARCH_MULTIPLATFORM
ARM_ERRATA_754327
ARM_ERRATA_764369

That didn't fix things, but I noticed this morning there are PL310
errata workarounds too that we should have enabled:

PL310_ERRATA_769419
PL310_ERRATA_727915
PL310_ERRATA_588369

I'm going to do testing with different combinations to see if I can
gather evidence that any of these errata are causing the problem we're
hitting. Of course, errata workarounds as with cache timing tweaks will
affect timings in the system and so could affect the triggering of our
problem without actually being the root cause.

-- 
Tixy
