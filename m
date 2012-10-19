From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 19 Oct 2012 16:00:27 +0200
Subject: RT throttling and suspend/resume (was Re: [PATCH] i2c: omap:
 revert "i2c: omap: switch to threaded IRQ support")
In-Reply-To: <20121018055136.GF11137@arwen.pp.htv.fi>
References: <alpine.DEB.2.00.1210150148080.16624@utopia.booyaka.com>
 <CAM=Q2csHTbR4rBe1HNr5-M3sG5wgdCv6dCnGLmNQEwo1gjCSGg@mail.gmail.com>
 <20121016133356.GG21801@arwen.pp.htv.fi>
 <87ipaanljt.fsf_-_@deeprootsystems.com>
 <20121017140002.GI11394@arwen.pp.htv.fi>
 <20121017143534.GJ11394@arwen.pp.htv.fi>
 <87txtsitpt.fsf@deeprootsystems.com>
 <20121018055136.GF11137@arwen.pp.htv.fi>
Message-ID: <1350655227.2768.11.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-10-18 at 08:51 +0300, Felipe Balbi wrote:
> > So the primary question remains: is RT runtime supposed to include the
> > time spent suspended?  I suspect not. 
> 
> you might be right there, though we need Thomas or Peter to answer :-s 

re, sorry both tglx and I have been traveling, he still is, I'm trying
to play catch-up :-)

Anyway, yeah I'm somewhat surprised the clock is 'running' when the
machine isn't. From what I could gather, this is !x86 hardware, right?

x86 explicitly makes sure our clocks are 'stopped' during suspend, see
commit cd7240c0b900eb6d690ccee088a6c9b46dae815a.

Can you do something similar for ARM? A quick look at
arch/arm/kernel/sched_clock.c shows there's already suspend/resume
hooks, do they do the wrong thing?
