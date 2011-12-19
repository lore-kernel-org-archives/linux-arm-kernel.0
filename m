From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 19 Dec 2011 12:44:14 -0500 (EST)
Subject: buggy usage of pm_idle by omap1 code
In-Reply-To: <20111219173518.GH6464@atomide.com>
References: <alpine.LFD.2.02.1112162208390.2907@xanadu.home>
 <20111219173518.GH6464@atomide.com>
Message-ID: <alpine.LFD.2.02.1112191243190.2907@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 19 Dec 2011, Tony Lindgren wrote:

> * Nicolas Pitre <nico@fluxnic.net> [111216 18:53]:
> > 
> > I just noticed in mach-omap1/cpu.c:omap_pm_prepare() that the function 
> > pointer pm_idle is explicitly set to NULL for some vague reason.  
> > However this pointer is unconditionally dereferenced in 
> > kernel/process.c:cpu_idle().  This is just a oops waiting to happen.  
> > And if it doesn't happen in practice, then the code in omap_pm_prepare() 
> > must be useless in addition to being wrong.
> 
> Good catch. Here's a patch to deal with that issue, want to take this
> into your idle series?

Sure.

> I'll try out your idle series today at some
> point.

Thanks.


Nicolas
