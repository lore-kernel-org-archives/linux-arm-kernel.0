From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Feb 2012 12:50:54 +0000
Subject: [PATCH 1/4 v2] i2c/gpio: add DT support
In-Reply-To: <20120220102231.GC11307@game.jcrosoft.org>
References: <1328754308-7365-1-git-send-email-plagnioj@jcrosoft.com>
 <4F3945B1.9070900@samsung.com> <20120220095813.GB11307@game.jcrosoft.org>
 <20120220100843.GE22562@n2100.arm.linux.org.uk>
 <20120220102231.GC11307@game.jcrosoft.org>
Message-ID: <20120220125054.GF22562@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 20, 2012 at 11:22:31AM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 10:08 Mon 20 Feb     , Russell King - ARM Linux wrote:
> > On Mon, Feb 20, 2012 at 10:58:13AM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > On 18:17 Mon 13 Feb     , Karol Lewandowski wrote:
> > > > > +	- udelay: delay between GPIO operations (may depend on each platform)
> > > > > +	- timeout: timeout to get data (ms)
> > > > 
> > > > 
> > > > If these are really needed then I would prefer to have these fully
> > > > qualified (with unit type "-ms/-millisecs" appended).
> > > > 
> > > > Regulator framework, with its "-microvolt/-microamp", serve here as
> > > > prime example of being quite descriptive (one doesn't neet to look up
> > > > the docs). Please see:
> > > > 
> > > >   http://permalink.gmane.org/gmane.linux.ports.arm.omap/67637
> > > timeout are usualy in ms I don't really see the need of -ms or so
> > 
> > Which is obviously total crap for udelay, which would be in _micro_seconds.
> agreed but here on i2c gpio I never see timetout as udelay so I don't see
> the mandatory to force the name in the binding
> 
> futhermore it's maybe linux specific

Stop grabbing at straws.  There's nothing linux specific about the units
of specification.

What is linux specific is specifying the _delay_ rather than specifying
the bus frequency.  So as soon as you're trying to justify not adding
the units because they may be linux specific, you've already lost that
argument by using a delay rather than a bus frequency.  You can't have
it both ways.

Moreover, mixing microseconds and milliseconds in the properties for a
device is absolutely insane.

So, which ever way, your patch as it currently stands is wrong and broken.
