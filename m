From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 8 Apr 2013 14:30:55 -0400
Subject: [PATCH v4 0/5] Device Bus support for Marvell EBU SoC
In-Reply-To: <20130408152933.GB877@localhost>
References: <1365419194-20871-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <201304081617.31644.arnd@arndb.de> <20130408152933.GB877@localhost>
Message-ID: <20130408183055.GA13280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 08, 2013 at 12:29:34PM -0300, Ezequiel Garcia wrote:
> On Mon, Apr 08, 2013 at 04:17:31PM +0200, Arnd Bergmann wrote:
> > On Monday 08 April 2013, Ezequiel Garcia wrote:
> > >   * Rename devbus,dev-width to devbus,bus-width and changed the
> > >     parameter value from bytes to bits: <8>, <16>, ...
> > >     Suggested by Arnd Bergmann.
> > > 
> > >   * As suggested by Jason Gunthorpe and agreed by Arnd Bergmann.
> > >     Reworked the whole devbus child chip-select device tree design.
> > >     Now there's a separate devbus at addr DT node for each controller
> > >     chip select. The impact of this is:
> > >       1. Timing parameters now go into the parent node.
> > >       2. There can only be one child per devbus node.
> > > 
> > >   * Remove unneeded bank-width parameter read.
> > > 
> > 
> > Whole series:
> > 
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > It may be nicer to use #address-cells=<2> for devbus device nodes now that
> > each of them has only a 32 bit address space, but the current code is correct
> > as well using a 64 bit notation.
> > 
> 
> I'll probably be sending a v5 fixing this later.
> 
> @Jason Cooper:
> How would you like to handle this, regarding the LPAE series?
> Do you want me to rebase this devbus on top of that?

Let's avoid the dependency and merge them both as is.  Once v3.10 drops,
you can send a fixup patch to move it to 64bit.

thx,

Jason.
