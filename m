From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Jun 2011 09:32:16 +0100
Subject: [RFC PATCH 00/16] Consolidation: move SMP local timers to
	driver/clocksource
In-Reply-To: <4DFF03FA.8030906@arm.com>
References: <1308251204-16719-1-git-send-email-marc.zyngier@arm.com>
	<201106171707.23989.arnd@arndb.de> <4DFB8E20.60802@gmail.com>
	<4DFF03FA.8030906@arm.com>
Message-ID: <20110620083216.GB26089@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2011 at 09:25:30AM +0100, Marc Zyngier wrote:
> On 17/06/11 18:25, Rob Herring wrote:
> > If this is the direction to go, then there are a lot of other timers
> > that can be moved besides just local timers. But Russell didn't really
> > like the shmobile patches for early platform devices which this relies
> > on. So we should get agreement on the small bit of infrastructure needed
> > first, then start moving individual timers.
> 
> I'm open to suggestions. Should the early platform infrastructure be
> flagged as unsuitable, I'd be happy to switch to something else, as long
> as it is minimal, and does not create another ARM-specific API (been
> there, done that...).

I am most certainly not a fan of the early platform device stuff as I've
said in the past.

It looks to me like:

1. it's overcomplex and fragile.
2. it abuses the early command line system.
3. it abuses platform devices etc.
4. it requires more initialization calls.

Lastly, and probably more importantly for the direction we're going, I
can't see how it would hook into DT other than using the DT provided
command line, which also appears to be an abuse there too.

Surely there's a better solution.
