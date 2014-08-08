From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 08 Aug 2014 16:23:09 +0200
Subject: [RFC PATCH v3] reset: Add a defer reset object to send board
 specific reset
In-Reply-To: <CACRpkdbFPAsu1gE-AVyD=-RxyE7mUJPSbFga7HLh0mxjE-mQuQ@mail.gmail.com>
References: <1403098673-3058-1-git-send-email-houcheng@gmail.com>
 <CACRpkdYfu8HmVCkn9JFh+YP5OPdr8o9nTfoCnkJ7SSpGoenQUg@mail.gmail.com>
 <20140708080535.GJ13423@lukather>
 <CACRpkdbFPAsu1gE-AVyD=-RxyE7mUJPSbFga7HLh0mxjE-mQuQ@mail.gmail.com>
Message-ID: <1407507789.3354.20.camel@paszta.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 08.07.2014, 11:38 +0200 schrieb Linus Walleij:
> On Tue, Jul 8, 2014 at 10:05 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Tue, Jul 08, 2014 at 09:52:03AM +0200, Linus Walleij wrote:
> >> On Wed, Jun 18, 2014 at 3:37 PM, Houcheng Lin <houcheng@gmail.com> wrote:
> >>
> >> > The Problem
> >> > -----------
> >> > The reset signal on a hardware board is send either:
> >> >     - during machine initialization
> >> >     - during bus master's initialization
> >>
> >> I just thought about this a bit, since there isn't already a generic GPIO
> >> reset driver, just call this drivers/reset/reset-gpio.c and make the
> >> ability to deferral just a configuration detail of the GPIO reset driver.
> >
> > Philipp has been working on one for quite some time. See
> > http://www.spinics.net/lists/arm-kernel/msg321927.html
> >
> > However, it seems to progress slowly, and we don't seem to be able to
> > reach a consensus here.

Mostly because Maxime and I seem to have a completely different opinion
and nobody else argued one way or the other.

> > If you ask me, having to set a few extra properties like this just
> > advocates for a regular reset driver and DT node for the reset GPIO,
> > but I'm pretty sure Philipp will feel otherwise :)
> 
> Hm haha yeah let's fight it out :-)
> 
> This is not my subsystem so I'm getting some popcorn.

Sorry about missing this earlier, I hope the popcorn is not stale.

I think a reset that needs to be released before a fixed device appears
on the bus, should be handled by the bus driver. The reset framework
could be made to help with that, but I don't think a separate entity
that scans the whole device tree itself is the right solution.

regards
Philipp
