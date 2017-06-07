From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 8 Jun 2017 01:17:15 +0200
Subject: [PATCH 46/58] clocksource/drivers: Add a new driver for the
 Atmel ARM TC blocks
In-Reply-To: <20170607210848.GJ2345@mai>
References: <20170530215139.9983-1-alexandre.belloni@free-electrons.com>
 <20170530215139.9983-47-alexandre.belloni@free-electrons.com>
 <20170606152104.GC2345@mai>
 <20170606180559.pkrr7ux2qqnmsd6y@piout.net>
 <20170607141735.GH2345@mai>
 <20170607152750.tksmyf5p3oajbsac@piout.net>
 <20170607210848.GJ2345@mai>
Message-ID: <20170607231715.ns2vcxza2eexnzjs@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/06/2017 at 23:08:48 +0200, Daniel Lezcano wrote:
> > I was going to agree but this is not flexible enough because the
> > quadrature decoder always uses the first two channels. So on some
> > products, we may have:
> >  - TCB0:
> >    o channels 0,1: qdec
> >    o channel 2: clocksource
> > 
> >  - TCB1:
> >    o channels 0,1: qdec
> >    o channel 2: clockevent
> > 
> > This avoids wasting TCB channels.
> 
> Ok. In this case you can check if the interrupt is specified for the node, if
> yes, then it is a clockevent.
> 

But currently it is always specified in the SoC's dtsi. I don't find
that too practical to push that to the board's dts. Also, lying by
omission (the IRQ is always wired) in the DT is not different from
having a property selecting which timer is the clocksource and which is
the clockevent.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
