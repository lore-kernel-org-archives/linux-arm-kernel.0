From: broonie@debian.org (Mark Brown)
Date: Tue, 12 Jan 2016 22:00:58 +0000
Subject: I/O issues with writing to mtdblock devices on kirkwood
In-Reply-To: <4468027.N4Q71mzei0@wuerfel>
References: <1440159857.19360.50.camel@debian.org> <4004455.tVDpSpUXxo@wuerfel>
 <20160112180223.GA6588@sirena.org.uk> <4468027.N4Q71mzei0@wuerfel>
Message-ID: <20160112220058.GE6588@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 12, 2016 at 10:49:57PM +0100, Arnd Bergmann wrote:

> I see in the Armada 370 datasheet that the controller actually supports an
> interrupt driven mode, which should be much better in principle than blocking
> the CPU during the entire transfer. There may of course be a good reason
> why the driver has never used interrupts, but it was originally introduced
> in Orion5x, so maybe there was a bug that has been fixed in the meantime.

There's also the potential for the overhead from interrupts to be worse
than the overhead for busy waiting, but given how badly we're coping now
it's worth another look.

I did also see a patch today that suggested that at least some of these
controllers have some kind of memory mapped mode but I don't know
exactly how that works (the patch was a little unclear).  There was some
suggestion that it performed well and if there's a free general purpose
DMA controller it might be able to work with this mode too.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160112/407fcbbc/attachment.sig>
