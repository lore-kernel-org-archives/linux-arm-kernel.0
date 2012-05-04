From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 4 May 2012 20:39:25 +0000
Subject: Handling of modular boards
In-Reply-To: <20120504203357.6B79B206451@gemini.denx.de>
References: <20120504185850.GO14230@opensource.wolfsonmicro.com>
 <201205041934.08830.arnd@arndb.de>
 <20120504203357.6B79B206451@gemini.denx.de>
Message-ID: <201205042039.25794.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 04 May 2012, Wolfgang Denk wrote:
> In message <201205041934.08830.arnd@arndb.de> you wrote:
> >
> > One idea that I've heard before is to put device tree fragments into the
> > kernel and dynamically add them to the device tree that was passed by the
> > boot loader whenever we detect the presence of a specific device.
> > This obviously means it works only for boards using DT for booting, but
> > it allows us to use some infrastructure that we already have.
> > 
> > Another idea was to put all the possible extensions into the device tree
> > for a given board and disable them by default, putting it into the
> > responsibility of the boot loader to enable the one that is actually
> > being used. This has serious scalibility problems when there are many
> > possible extensions and also relies more on the boot loader than I would
> > like.
> 
> On the other hand, some of the issues we're trying to solve here
> for the kernel are also present in the boot loader, so this needs to
> do this anyway - whether by inserting new or modifying (enabling or
> disabling) existing properties in the DT is not really relevant here.

I haven't seen a case where the add-on board is actually required
for booting. What examples are you thinking of?

	Arnd
