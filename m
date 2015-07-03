From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 3 Jul 2015 16:53:49 +0200 (CEST)
Subject: Possible regression due to "tick: broadcast: Prevent livelock
 from event handler"
In-Reply-To: <20150703143703.GB19284@katana>
References: <20150703024044.GB24695@verge.net.au>
 <20150703105441.GF1521@katana> <alpine.DEB.2.11.1507031511180.3916@nanos>
 <20150703133245.GA19284@katana> <alpine.DEB.2.11.1507031612410.3916@nanos>
 <20150703143703.GB19284@katana>
Message-ID: <alpine.DEB.2.11.1507031640060.3916@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 3 Jul 2015, Wolfram Sang wrote:
> > So this is a single core machine and uses the em_sti timer w/o the
> > broadcast nonsense. In Simons case it looks like em_sti is used as
> > broadcast device.
> 
> We use the same board. Just my kernel has SMP=n.
> 
> > Though the issues you see in the highres=n case might be the same as
> > the ones Simon is observing.
> 
> I hope so. One good thing about the issue I see is that it is 100%
> reproducable.
> 
> > So in that nohz=y highres=n case, does adding idle=poll on the command
> > line fix the issue?
> 
> Nope, still hangs.

Ok. So it's unrelated to deep idle states. Any chance of poking with
JTAG at the frozen box? If not, are there GPIOs which you could use to
monitor certain state?

Thanks,

	tglx
