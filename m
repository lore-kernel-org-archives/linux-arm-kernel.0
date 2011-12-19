From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 19 Dec 2011 14:25:25 -0500 (EST)
Subject: [PATCH 00/20] arch_idle() cleanup and mach/system.h removal
In-Reply-To: <20111219185706.GG2376@gallagher>
References: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
 <20111219185706.GG2376@gallagher>
Message-ID: <alpine.LFD.2.02.1112191424390.2907@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 19 Dec 2011, Jamie Iles wrote:

> Hi Nicolas,
> 
> On Mon, Dec 19, 2011 at 04:47:29AM -0500, Nicolas Pitre wrote:
> > This is the logical continuation of the arch_reset() work that Russell did
> > and therefore this must be applied on top of Russell's "reset" branch.
> > 
> > Most arch_idle() implementations are simply a call to cpu_do_idle() and
> > can be eliminated in favor of a common call.  However, some platforms
> > require special idle handling and the arm_pm_idle hook is made available
> > for those cases.
> > 
> > Why "arm_pm_idle"?  Because there is already a generic "pm_idle", but its
> > calling convention is rather awkward with regard to interrupts, so the
> > default "pm_idle" handler will call arm_pm_idle if it is non null, or
> > cpu_do_idle otherwise.  The generic pm_idle hook still can be overriden
> > as before.
> > 
> > This series is therefore meant to be functionally a big no-op i.e.
> > everything should just behave as before, despite having more than 1000
> > lines of code and 55 files removed in the end.
> 
> Tested on picoxcell, works great.
> 
> Acked-and-tested-by: Jamie Iles <jamie@jamieiles.com>

Great!

> btw,
> 
> > [PATCH 20/20] ARM: big removal of now unused arch_reset()
> 
> I guess this should be "ARM: big removal of now unused mach/system.h" or 
> similar?

Indeed!


Nicolas
