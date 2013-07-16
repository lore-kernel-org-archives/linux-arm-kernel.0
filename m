From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 16 Jul 2013 09:14:33 -0300
Subject: [PATCH 00/10] Orion Watchdog fixes
In-Reply-To: <20130716073101.GB25043@lunn.ch>
References: <1373931163-12670-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130716065952.GA25043@lunn.ch> <20130716092059.237ea729@skate>
 <20130716073101.GB25043@lunn.ch>
Message-ID: <20130716121432.GA2317@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas, Andrew:

Thanks for looking at this!

On Tue, Jul 16, 2013 at 09:31:01AM +0200, Andrew Lunn wrote:
> On Tue, Jul 16, 2013 at 09:20:59AM +0200, Thomas Petazzoni wrote:
> > 
> > On Tue, 16 Jul 2013 08:59:52 +0200, Andrew Lunn wrote:
> > 
> > > Maybe i'm missing something here. You are making use of
> > > orion_timer_ctrl_clrset() from time-orion.c. How will this work on
> > > 370/XP which has a different clocksource driver?
> > 
> > I *think* the idea is that the Armada 370/XP driver will expose the
> > same function, so from the point of view of the watchdog driver, it
> > will just work.

Indeed that was one of the ideas. As Thomas said, this was just
preparation work.

> 
> That was what i was thinking would happen. And then i started to
> wonder how well the kernel linker deals with multiple definitions of
> the same symbol. Dove and 370/XP can end up in the same kernel. So we
> need to have both orion-timer and the 370/XP timer in the same kernel,
> so we end up with the same symbol in the kernel twice...
> 

Yeah, well... I wasn't sure about using the same name, so another approach
would be adding a new compatible to the driver and then make it use the
appropriate function in the 370/XP clocksource driver (with a different name).

And, yet another approach, is what Sebastian just said, although I'm
not sure I understood it :). In any case, we have already several solutions,
which is why I'm not too worried about this particular issue.

On the other side, I'm much interested in knowing if you are OK with
breaking the watchdog DT compatibility. If you NACK this, then I'll
start preparing a different watchdog driver for 370/XP, since I don't
want to extend a driver that is a bit dirty.

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
