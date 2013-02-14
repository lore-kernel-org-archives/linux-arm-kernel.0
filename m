From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Feb 2013 11:12:16 +0000
Subject: Build error: OMAP randconfig / mvebu
In-Reply-To: <20130214110307.GA3059@localhost>
References: <20130208100813.GN17833@n2100.arm.linux.org.uk>
 <20130214100926.GO17852@n2100.arm.linux.org.uk>
 <20130214110307.GA3059@localhost>
Message-ID: <201302141112.16287.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 14 February 2013, Ezequiel Garcia wrote:
> On Thu, Feb 14, 2013 at 10:09:26AM +0000, Russell King - ARM Linux wrote:
> > On Fri, Feb 08, 2013 at 02:33:29PM +0100, Arnd Bergmann wrote:
> > > On Friday 08 February 2013 12:06:44 Gregory CLEMENT wrote:
> > > > 
> > > > I don't know what to do here, there is no point to build any of the files
> > > > in mach-mvebu if no SoCs are selected. So either we force to have at least
> > > > one SoCS selected if ARCH_MVEBU is selected, or we unselect  ARCH_MVEB if
> > > > no SoCs are selected.
> > > 
> > > The latter does not work, because that would introduce a circular
> > > dependency in Kconfig.
> > > 
> > > I suppose rearranging the mvebu Makefile like this would do.
> > > 
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > This error is still present in arm-soc.  We're getting close to the next
> > merge window, so either something needs to be dropped from arm-soc, or
> > this needs to get fixed.
> > 
> 
> Can you point me to where can I get the config your building with?

It is essentially any configuration that turns on ARCH_MVEBU but not
MACH_ARMADA_370 or MACH_ARMADA_XP.

	Arnd
