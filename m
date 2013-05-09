From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 9 May 2013 15:36:26 -0400 (EDT)
Subject: [RFC PATCH 1/2] USB: OHCI: prepare to make ohci-hcd a library
 module
In-Reply-To: <201305092125.01607.arnd@arndb.de>
Message-ID: <Pine.LNX.4.44L0.1305091530330.1796-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 9 May 2013, Arnd Bergmann wrote:

> On Thursday 09 May 2013, Alan Stern wrote:
> > > > The #else part of this isn't needed, and I doubt very much that it
> > > > would work correctly if it was needed.
> > >
> > > As Arnd suggestion,so I written else part.
> > 
> > The existing code doesn't have a #else part, and I don't think you need 
> > to add one.
> 
> I had commented in an earlier (Linaro internal) review that function
> declarations should not be hidden inside of an #ifdef unless there
> is an #else clause defining an alternative.
> 
> I did not want to suggest with that adding an #else for the fun of it,
> of course it should only be there if actually needed.

Well, empty inline function definitions don't have any runtime cost, so
there's nothing really wrong with it.  But it does give the impression
that it's okay to try calling these routines when CONFIG_PM isn't
enabled, which isn't true.  Either the result won't be what you
expected, or else you shouldn't be calling them in the first place.

Alan Stern

PS: If the proposed __pm annotation is added (see 
http://marc.info/?l=linux-pm&m=136811978510598&w=2) then this whole 
discussion will become moot.  :-)
