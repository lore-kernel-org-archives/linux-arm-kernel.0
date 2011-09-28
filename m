From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 28 Sep 2011 13:26:28 +0100
Subject: [PATCH 8/9] regulator: helper to extract regulator node based on
	supply name
In-Reply-To: <4E82D63A.7030207@ti.com>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com>
	<1317118372-17052-9-git-send-email-rnayak@ti.com>
	<20110927122155.GE4289@opensource.wolfsonmicro.com>
	<4E81E281.505@ti.com>
	<20110927185913.GU4289@opensource.wolfsonmicro.com>
	<4E82D63A.7030207@ti.com>
Message-ID: <20110928122628.GF3279@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 28, 2011 at 10:09:30AM +0200, Cousson, Benoit wrote:
> On 9/27/2011 8:59 PM, Mark Brown wrote:

> >I'm not sure how this should work in a device tree world, I'd *hope*
> >we'd get a device tree node for the CPU and could then just make this a
> >regular consumer thing but then the cpufreq drivers would need to be
> >updated to make use of it.  The only reason we allow null devices right
> >now is the fact that cpufreq doesn't have a struct device it can use.

> That's why we do have a MPU node in OMAP dts, in order to build an
> omap_device that will be mainly used for the DVFS on the MPU.

> And even before DT migration, we used to build statically some
> omap_device to represent the various processors in the system (MPU,
> DSP, CortexM3...).

Yeah, but that's very OMAP specific - we don't have that in general (in
fact it's the only Linux platform I'm aware of that has a device for the
CPU).
