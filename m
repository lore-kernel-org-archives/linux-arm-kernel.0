From: broonie@kernel.org (Mark Brown)
Date: Tue, 23 Jul 2013 20:31:05 +0100
Subject: [PATCH 01/15] drivers: phy: add generic PHY framework
In-Reply-To: <20130723180110.GA8688@kroah.com>
References: <Pine.LNX.4.44L0.1307231017290.1304-100000@iolanthe.rowland.org>
 <51EE9EC0.6060905@ti.com> <20130723161846.GD2486@kroah.com>
 <1446965.6APW5ZgLBW@amdc1227> <20130723173710.GB28284@kroah.com>
 <20130723174456.GM9858@sirena.org.uk>
 <20130723180110.GA8688@kroah.com>
Message-ID: <20130723193105.GP9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 23, 2013 at 11:01:10AM -0700, Greg KH wrote:
> On Tue, Jul 23, 2013 at 06:44:56PM +0100, Mark Brown wrote:

> > What are the problems you are seeing with doing things with lookups?

> You don't "know" the id of the device you are looking up, due to
> multiple devices being in the system (dynamic ids, look back earlier in
> this thread for details about that.)

I got copied in very late so don't have most of the thread I'm afraid, 
I did try looking at web archives but didn't see a clear problem
statement.  In any case this is why the APIs doing lookups do the
lookups in the context of the requesting device - devices ask for
whatever name they use locally.

> > Having to write platform data for everything gets old fast and the code
> > duplication is pretty tedious...

> Adding a single pointer is "tedious"?  Where is the "name" that you are
> going to lookup going to come from?  That code doesn't write itself...

It's adding platform data in the first place that gets tedious - and of
course there's also DT and ACPI to worry about, it's not just a case of
platform data and then you're done.  Pushing the lookup into library
code means that drivers don't have to worry about any of this stuff.

For most of the APIs doing this there is a clear and unambiguous name in
the hardware that can be used (and for hardware process reasons is
unlikely to get changed).  The major exception to this is the clock API
since it is relatively rare to have clear, segregated IP level
information for IPs baked into larger chips.  The other APIs tend to be
establishing chip to chip links.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130723/3c3ea43f/attachment-0001.sig>
