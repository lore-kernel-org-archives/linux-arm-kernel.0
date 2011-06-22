From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 22 Jun 2011 18:35:05 +0200
Subject: i.MX consolidation patches
In-Reply-To: <20110622152251.GV23234@n2100.arm.linux.org.uk>
References: <20110601123522.GE23771@pengutronix.de>
	<20110601134749.GI3660@n2100.arm.linux.org.uk>
	<20110601141847.GG23771@pengutronix.de>
	<20110601142406.GJ3660@n2100.arm.linux.org.uk>
	<20110622075615.GJ6069@pengutronix.de>
	<20110622081141.GN23234@n2100.arm.linux.org.uk>
	<20110622083257.GK6069@pengutronix.de>
	<20110622090321.GO23234@n2100.arm.linux.org.uk>
	<20110622145828.GL6069@pengutronix.de>
	<20110622152251.GV23234@n2100.arm.linux.org.uk>
Message-ID: <20110622163505.GM6069@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 22, 2011 at 04:22:51PM +0100, Russell King - ARM Linux wrote:
> On Wed, Jun 22, 2011 at 04:58:28PM +0200, Sascha Hauer wrote:
> > On Wed, Jun 22, 2011 at 10:03:21AM +0100, Russell King - ARM Linux wrote:
> > > That's rather my point: PATCH_PHYS_TO_VIRT=y does not mean that the
> > > uImage is unbootable - it's only unbootable if the uImage has a
> > > load/start address which is invalid for the platform.
> > > 
> > > So, maybe the idea of changing LOADADDR is better.  Or maybe providing
> > > Makefile.boot with a new variable 'nouimage' which can provide the
> > > same functionality - and you may wish to provide LOADADDR on the command
> > > line and detect that, in which case it should override this lockout.
> > 
> > Then I have the same problem in my platform because I have no clear
> > condition on which to set this variable. Currently there is no "more
> > than one zreladdr" indicator. Maybe a variant of the following patch
> > is the least of all evils. A mechanism to specify the load address on
> > the command line could be added.
> 
> I think your patch looks good so far, but with one exception - we probably
> want to detect off LOADADDR so that we can override it by passing
> 'make uImage LOADADDR=blah'.  That would allow uImage's to be generated
> without having to learn all the silly the mkimage command line arguments.
> 
> The other issue here is that having multiple words in ZRELADDR without
> AUTO_ZRELADDR enabled in the decompressor is going to lead to decompressor
> link time errors - so that's something else which needs thinking about.

Having multiple ZRELADDR without AUTO_ZRELADDR is broken anyway, so all
we have to do here is to provide a hint to the user instead of failing
in the linker, right?



-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
