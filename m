From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Fri, 01 May 2015 09:52:28 +0100
Subject: [PATCH] arm64: dts: Add idle-states for Juno
In-Reply-To: <5542690F.5060001@arm.com>
References: <1430402268.2868.20.camel@linaro.org> <554251B4.2030808@arm.com>
 <1430412035.2868.40.camel@linaro.org> <20150430171701.GA31834@red-moon>
 <1430415404.2868.49.camel@linaro.org> <5542690F.5060001@arm.com>
Message-ID: <1430470348.3045.10.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-04-30 at 18:40 +0100, Sudeep Holla wrote:
> 
> On 30/04/15 18:36, Jon Medhurst (Tixy) wrote:
> > On Thu, 2015-04-30 at 18:17 +0100, Lorenzo Pieralisi wrote:
> >> On Thu, Apr 30, 2015 at 05:40:35PM +0100, Jon Medhurst (Tixy) wrote:
> >>> On Thu, 2015-04-30 at 17:00 +0100, Sudeep Holla wrote:
> >>>>
> >>>> On 30/04/15 14:57, Jon Medhurst (Tixy) wrote:
> >>>>> From: Jon Medhurst <tixy@linaro.org>
> >>>>>
> >>>>> Signed-off-by: Jon Medhurst <tixy@linaro.org>
> >>>>> ---
> >>>>>
> >>>>> These have been kicking around out of tree for ages, any reason they
> >>>>> shouldn't be in mainline?
> >>>>
> >>>> One possible reason could be that these values are not tuned(e.g.
> >>>> latency values, can they be same for both clusters ?)
> >>>
> >>> I thought that both clusters being the same was questionable.
> >>>
> >>>>   Though these
> >>>> reasons are not blocking and this patch will not cause any
> >>>> functionality break even if is merged as is.
> >>>
> >>> My main purpose with trying to get this merged is so that people using
> >>> Juno for general testing and validation will actually have cpuidle
> >>> running and so potentially find more bugs.
> >>
> >> I am reluctant to enable idle states in the default Juno dts, they
> >> will affect latencies and performance tests significantly. I should
> >> find a way to disable them by default and possibly have a DT property
> >> to enabled them explicitly, we can't merge the dts as it is we have
> >> to change the CPUidle code first.
> >
> > Presumably the same argument goes for cpufreq? That'll upset people
> > doing performance benchmarks, so shouldn't be enabled by default?
> >
> 
> Or we can have cpufreq enabled with performance governor as default ;)

Which will crank the cpu clock up to max (1.1GHz on the A57s), which is
higher than what you get without cpufreq in the kernel (850MHz) so
everyone's performance measurements will suddenly go faster.

I don't know if that is a problem for the usecase's Lorenzo wants the
default Juno setup to satisfy.

-- 
Tixy
