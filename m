From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 8 Jun 2017 01:11:39 +0200
Subject: [PATCH 46/58] clocksource/drivers: Add a new driver for the
 Atmel ARM TC blocks
In-Reply-To: <20170607213810.GK2345@mai>
References: <20170530215139.9983-1-alexandre.belloni@free-electrons.com>
 <20170530215139.9983-47-alexandre.belloni@free-electrons.com>
 <20170606152104.GC2345@mai>
 <20170606180559.pkrr7ux2qqnmsd6y@piout.net>
 <20170607141735.GH2345@mai>
 <20170607150908.kytgtzwgjjnxtsp3@piout.net>
 <20170607213810.GK2345@mai>
Message-ID: <20170607231139.5dgzu3tc4lmuj43y@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/06/2017 at 23:38:10 +0200, Daniel Lezcano wrote:
> On Wed, Jun 07, 2017 at 05:09:08PM +0200, Alexandre Belloni wrote:
> I suggest to look what is in 'lot-of-things()' and especially what is doing
> regcache_read().
> 

I know it does a lot...

> May be you can reconsider the regmap? This driver is the only one use the
> regmap AFAICT and I don't think it is adequate.
> 

That is not true, I also converted the PWM driver and both a capture and
qdec drivers are coming.



> > > > > Can you explain why we have two clocks here?
> > > > > 
> > > > 
> > > > Each channel have its clock, I can add a comment if you want.
> > > 
> > > I don't understand. Why do we have two clocks?
> > > 
> > > One channel is driven by one clock and the second one takes the overflow signal
> > > from the first one, so no second clock is involved there, no?
> > > 
> > 
> > Those are the peripheral clocks, they are not used by the counters but
> > used to be able to read/write the registers.
> 
> Mmh, strange. Why is the clk[0]'s rate used in this case?
> 

That's abusing the fact that is has the same rate as the clock feeding
the counter.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
