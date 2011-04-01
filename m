From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 1 Apr 2011 13:22:44 +0200
Subject: [GIT PULL] omap changes for v2.6.39 merge window
In-Reply-To: <1301643157.3393.17.camel@deskari>
References: <201103301906.42429.arnd@arndb.de>
	<201103311723.02301.arnd@arndb.de>
	<1301643157.3393.17.camel@deskari>
Message-ID: <201104011322.44729.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 01 April 2011, Tomi Valkeinen wrote:
> On Thu, 2011-03-31 at 17:23 +0200, Arnd Bergmann wrote:
> 
> > * The DSS display drivers introduce new infrastructure include new bus
> >   types that have the complexity to make them completely generic, but
> >   in practice can only work on OMAP, and are clearly not written with
> >   cross-vendor abstractions in mind.
> 
> If you mean the panel drivers, then I disagree. They are currently OMAP
> specific, but they are designed so that making them generic shouldn't be
> too difficult. It's been my aim for a long time already to make the
> panel drivers generic, but I've never had time and it's never been quite
> clear to me what would be the best way to do that.
> 
> The core DSS driver is OMAP specific, and while the DSS IP could in
> theory be used in some other platform, that is not currently the case
> and I wouldn't want to needlessly start abstracting things for just the
> sake of abstracting.

Ok, fair enough. I haven't looked at the OMAP DSS code in detail, so
I apologise if I did it injustice. What I did review is the ST Ericsson
MCDE code which was written by taking the OMAP code as an example.

The symptom I'm describing is that infrastructure is getting added
to platform specific code without making clear that it is mean to
be generic. I.e. the code is hidded away in the drivers/video/omap
directory, where other people would not go looking for it.

What I would have hoped you to do is to tell the ST Ericsson people
when they posted their code that they should instead work with you
to integrate the two implementations. As far as I remember (I may be
wrong again), that did not happen.

	Arnd
