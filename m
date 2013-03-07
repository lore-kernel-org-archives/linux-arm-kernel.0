From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 7 Mar 2013 23:42:34 +0800 (HKT)
Subject: [PATCH 00/16] big.LITTLE low-level CPU and cluster power
 management
In-Reply-To: <20130307145106.GA7451@amd.pavel.ucw.cz>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
 <20130307082721.GB28982@xo-6d-61-c0.localdomain>
 <alpine.LFD.2.03.1303071701330.28820@syhkavp.arg>
 <20130307094017.GA6337@amd.pavel.ucw.cz>
 <alpine.LFD.2.03.1303071753280.28820@syhkavp.arg>
 <20130307145106.GA7451@amd.pavel.ucw.cz>
Message-ID: <alpine.LFD.2.03.1303072335120.28820@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 7 Mar 2013, Pavel Machek wrote:

> Hi!
> 
> > > > > I'd say:
> > > > > 
> > > > > * expose all 8 cores.
> > > > 
> > > > You may do that now.  However the resulting power efficiency is far from 
> > > > optimal.
> > > 
> > > Really? Assuming the lwn article is accurate, it will be exactly the
> > > same.
> > > 
> > > I propose exposing all 8 cores, then keeping 4 of them offline in
> > > normal operation. This should have characteristics of your solution,
> > > except that cpu does not change unexpectedly under the pinned tasks.
> > > 
> > > > > * as long as scheduler is not ready, you can offline "the other" set of cores...
> > > > > 	/sys/.../cpu/..../online
> > > > 
> > > > You may do that now also.  But system performance is far from optimal.
> > > 
> > > Really? Do the offlining from the cpufreq code, and solution will be
> > > equivalent to yours, except the hacks.
> > 
> > No it is not equivalent.  Offlining a CPU is a fairly heavy operation in 
> > Linux and you don't want to do that multiple times per second for 
> > example.  Whereas the switcher "hack" is similar to a context switch in 
> > terms of software complexity.
> 
> Well, why not. Logically, you _are_ saving state, offlining, onlining,
> and restoring state, multiple times per second, already. 

Maybe "logically", but in practice there is no actual 
offlining/onlining but rather a migration.

> Fast offline/online benefits everyone...

Absolutely! You could ask tglx and cie where they are with their attempt 
at making hotplug less costly?

> As for the hacks... what does /proc/cpuinfo show on your system? What
> happens when process requests binding to specific cpu? I fear that
> switching hack is easy now, but will have unnice impact on unexpected
> places.
> 
> BTW I guess this should be discussed on linux-kernel, not on the arm
> list.

There is nothing to discuss until I'm ready to show you the code.


Nicolas
