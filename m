From: broonie@kernel.org (Mark Brown)
Date: Tue, 24 Jun 2014 12:12:49 +0100
Subject: [PATCH] regmap: Add Kconfig option for debugfs register writes
In-Reply-To: <20140618210159.GC32450@pengutronix.de>
References: <1403033795-9122-1-git-send-email-mpa@pengutronix.de>
 <20140618001127.GC5099@sirena.org.uk>
 <20140618210159.GC32450@pengutronix.de>
Message-ID: <20140624111249.GK23300@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 18, 2014 at 11:01:59PM +0200, Markus Pargmann wrote:
> On Wed, Jun 18, 2014 at 01:11:27AM +0100, Mark Brown wrote:

> > This is deliberately hard to enable in order to make it clear that it
> > should never, ever be used in production as a bodge around writing
> > drivers and generally in order to reduce the risk to the rest of the
> > system.  Enabling this will typically give userspace full access to
> > components like PMICs which have the potential to cause physical damage
> > to the system if misused.

> The userspace already has full access to all those registers if you
> want. For example memory mapped registeres can be written through
> /dev/mem. I2C registers can easily be changed using i2c-tools or the
> /dev/i2c-* devices. So you are already able to write a userspace driver
> if you really want to.

Right, but in all cases except for /dev/mem the API ensures that you
can't simultaneously run a kernel and userspace driver.  It's not the
userspace driver bit that's the problem but rather having both at the
same time.

> I think this kconfig option would make it easier to debug hardware or
> driver issues, as it is much more comfortable to have a clean kconfig
> option.

Well, a major goal of doing things this way is to make it seem wrong to
be using this too much!  :P
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140624/3d643e17/attachment-0001.sig>
