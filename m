From: mingo@elte.hu (Ingo Molnar)
Date: Mon, 13 Sep 2010 10:51:37 +0200
Subject: [PATCH V3 0/6] Generalise ARM perf-events backend for oprofile
In-Reply-To: <20100913075025.GA14882@console-pimps.org>
References: <cover.1284357372.git.matt@console-pimps.org>
	<SNT125-W35B89F6AA83C8DD22E7946BA770@phx.gbl>
	<20100913075025.GA14882@console-pimps.org>
Message-ID: <20100913085137.GE23741@elte.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Matt Fleming <matt@console-pimps.org> wrote:

> On Mon, Sep 13, 2010 at 09:13:32AM +0200, Marc Titinger wrote:
> > 
> > Hi, 
> > 
> > I'm just being curious : do these patches change the way those chips 
> > should be supported, that do not have a PMU-like IP, but implement 
> > PC-sampling thanks to a general purpose timer (not the system timer) 
> > ?
> 
> CPUs that do not have a PMU are not required to use the perf-events 
> oprofile backend, it is entirely optional. The pc-sampling timer in 
> oprofile is not affected by this series.

It should still work fine though: a generalized oprofile backend should 
simply use hrtimer based events. That also has a chance to be higher 
quality than the system time fallback, on PMU-less (but high-res-timer 
capable) systems.

Thanks,

	Ingo
