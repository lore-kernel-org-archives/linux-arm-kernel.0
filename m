From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Fri, 1 May 2015 11:22:02 +0100
Subject: [PATCH] arm64: dts: Add idle-states for Juno
In-Reply-To: <20150501101211.GB11403@red-moon>
References: <1430402268.2868.20.camel@linaro.org> <554251B4.2030808@arm.com>
 <1430412035.2868.40.camel@linaro.org>
 <20150430171701.GA31834@red-moon>
 <20150501090201.GE27755@e104818-lin.cambridge.arm.com>
 <20150501101211.GB11403@red-moon>
Message-ID: <20150501102202.GU7440@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 01, 2015 at 11:12:11AM +0100, Lorenzo Pieralisi wrote:
> On Fri, May 01, 2015 at 10:02:02AM +0100, Catalin Marinas wrote:
> > On Thu, Apr 30, 2015 at 06:17:01PM +0100, Lorenzo Pieralisi wrote:
> > > On Thu, Apr 30, 2015 at 05:40:35PM +0100, Jon Medhurst (Tixy) wrote:
> > > > On Thu, 2015-04-30 at 17:00 +0100, Sudeep Holla wrote:
> > > > > On 30/04/15 14:57, Jon Medhurst (Tixy) wrote:
> > > > > > From: Jon Medhurst <tixy@linaro.org>
> > > > > >
> > > > > > Signed-off-by: Jon Medhurst <tixy@linaro.org>
> > > > > > ---
> > > > > >
> > > > > > These have been kicking around out of tree for ages, any reason they
> > > > > > shouldn't be in mainline?
> > > > > 
> > > > > One possible reason could be that these values are not tuned(e.g.
> > > > > latency values, can they be same for both clusters ?)
> > > > 
> > > > I thought that both clusters being the same was questionable.
> > > > 
> > > > >  Though these
> > > > > reasons are not blocking and this patch will not cause any
> > > > > functionality break even if is merged as is.
> > > > 
> > > > My main purpose with trying to get this merged is so that people using
> > > > Juno for general testing and validation will actually have cpuidle
> > > > running and so potentially find more bugs.
> > > 
> > > I am reluctant to enable idle states in the default Juno dts, they
> > > will affect latencies and performance tests significantly.
> > 
> > OTOH, I guess they will improve the power benchmarks. IMO, we should
> > place in the DT whatever the hardware and firmware supports. It's up to
> > those doing benchmarks to disable CPU suspend.
> 
> I am ok with DT defining whatever HW and FW support, the question is
> whether we want CPUidle (and CPUfreq) enabled by default in the
> defconfig then.
> 
> This will certainly trigger mainline regressions from a latency/performance
> standpoint (true, some tests disable idle states by default ie cyclic
> test), unless we disable CPUidle via command line parameter or we
> force people carrying out tests to disable idle states through sysfs knobs.

Hi Lorenzo,

Do you have any specific tests in mind that you are afraid of breaking? Would
enabling the performance CPUfreq driver by default not be enough to cover those
tests, like Sudeep suggested?

Best regards,
Liviu

> 
> Lorenzo
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
