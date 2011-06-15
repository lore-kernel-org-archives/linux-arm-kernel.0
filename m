From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Jun 2011 22:03:42 +0200
Subject: [MPCore Watchdog]: Convert from misc_dev to dynamic device node.
In-Reply-To: <BANLkTi=_DDxRqhqi=9Me6gWmm2h3wb5Zng@mail.gmail.com>
References: <BANLkTinaQpnVxwX5rB1jrabGX6ArvhhS7g@mail.gmail.com>
	<201106152136.23971.arnd@arndb.de>
	<BANLkTi=_DDxRqhqi=9Me6gWmm2h3wb5Zng@mail.gmail.com>
Message-ID: <201106152203.42250.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 15 June 2011 21:49:43 Peter Fordham wrote:
> On 15 June 2011 12:36, Arnd Bergmann <arnd@arndb.de> wrote:
> > Let's first wait until the generic watchdog framework gets merged and
> > the drivers are converted. After that is in, we can discuss further changes.
> 
> That seems logical and reasonable. Are we saying no changes to watchdog
> drivers in general until this is done? because I have other patches
> for this driver
> that among other things actually make it work properly. As it stands today
> the timeout calculations are broken which results in random reboots.

I mean only user-visible changes.
 
> The framework patch was submitted 3.5 months ago and isn't in yet. Is it held up
> on something? I don't see any negative comments.

I think Wim has been working on this on and off for years. I'm trying to
encourage him to just put it into linux-next now and merge the stuff for
the 3.1 merge window. I think having over 100 drivers implementing the
same interface with trivial differences is no fun any more.

> > I highly doubt that making an incompatible API change benefits anyone here,
> > but it certainly shouldn't be done for a single driver that is separate from
> > the framework.
> 
> Not to be a pedant but, this doesn't change the API at all.

It does change the default name of the device node, and the major/minor
number, which are user-visible. It's quite possible that there are systems
relying on static device nodes with this driver, and I'm rather sure that
that are systems around relying on static device nodes with other
watchdogs.

	Arnd
