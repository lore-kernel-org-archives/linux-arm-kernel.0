From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Tue, 15 May 2018 19:26:51 +0200
Subject: [PATCH v4 0/6] clocksource: rework Atmel TCB timer driver
In-Reply-To: <20180502181046.GG19273@piout.net>
References: <20180418105143.3577-1-alexandre.belloni@bootlin.com>
 <20180426164623.tlv6kz5yopk6voxx@breakpoint.cc>
 <20180426185233.GU4813@piout.net>
 <20180502133418.xa26c5ta2ytxxjcn@linutronix.de>
 <20180502181046.GG19273@piout.net>
Message-ID: <20180515172651.bhgaxta3czqgjpgu@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-05-02 20:10:46 [+0200], Alexandre Belloni wrote:
> > > As said below, this is solving multiple issues, including the one for
> > > SoCs that don't have the PIT.
> > will the PIT be removed? Where it needs the PIT?
> > 
> 
> The last patch is unselecting the PIT driver so by default it is not
> enabled. The PIT driver will stay just in case someone has to use it
> e.g. when they are using all the TCB channels for something else.
> However, recent Atmel SoC have a TCB without any output so it can ony be
> used as a timer. Some other SoCs don't have a PIT at all.

The question was more "does it make sense to keep the 'old' PIT driver
around or can it be removed and the TCB driver will be used by
everyone"?

> > > The remaining one would be "clocksource: TCLIB: Allow higher clock rates
> > > for clock events"
> > 
> > I see. So I would need to keep that patch in queue after it was
> > dismissed from duty?
> 
> Boris suggested a DT binding to allow changing the rate but it didn't
> reach consensus at the time. this is something that will ne to be
> revived at some point and I would very much like having that upstream
> too.

Does make sense to have a low frequency clock here? I think from
clocksource point of view it makes sense to have it (highres) enabled
and not having to adjust the DT first (not to mention to learn about
it).

Sebastian
