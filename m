From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 8 Oct 2015 19:34:28 +0100
Subject: [PATCH v4] twd: Don't set CLOCK_EVT_FEAT_C3STOP unconditionally
In-Reply-To: <5616B503.6090408@free.fr>
References: <56123BD0.8010005@sigmadesigns.com>
 <56124035.6080107@sigmadesigns.com>
 <CACRpkdbWRU3UH6aJnqdcuzdh_-sE7ryhs0vBTUbbRDcJ7PWXLw@mail.gmail.com>
 <561247DF.1000308@sigmadesigns.com>
 <20151005103539.GC19064@leverpostej>
 <5612649C.5020401@sigmadesigns.com>
 <20151008171616.GG7275@leverpostej> <5616AA2D.2070101@free.fr>
 <20151008175734.GH7275@leverpostej> <5616B503.6090408@free.fr>
Message-ID: <20151008183428.GI7275@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 08, 2015 at 08:25:07PM +0200, Mason wrote:
> On 08/10/2015 19:57, Mark Rutland wrote:
> >> Is it possible that twd_local_timer_common_register() would be
> >> called more than once?
> >>
> >> twd_local_timer_register() guards against multiple invocations,
> >> but twd_local_timer_of_register() doesn't (but maybe there is
> >> some guarantee from OF, or it's invalid to have multiple
> >> "arm,cortex-a9-twd-timer" strings in the DT).
> > 
> > It does appear that were you to have have two or more
> > "arm,cortex-a9-twd-timer" nodes in the DT, things would go wrong. As far
> > as I am aware, that would result in multiple calls to
> > twd_local_timer_of_register.
> > 
> > I don't think it would ever be valid to have two nodes for this
> > particular device, but it's probably worth having the same check as
> > twd_local_timer_register does, with a warning that there was more than
> > one such node logged to the console.
> 
> Hmmm, I think I'll do it in a follow-up patch, once Felipe's
> revert hits mainline.

Sure, this is certainly independent of the CLOCK_EVT_FEAT_C3STOP patch.

Thanks,
Mark.
