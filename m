From: broonie@kernel.org (Mark Brown)
Date: Tue, 12 Jan 2016 18:02:23 +0000
Subject: I/O issues with writing to mtdblock devices on kirkwood
In-Reply-To: <4004455.tVDpSpUXxo@wuerfel>
References: <1440159857.19360.50.camel@debian.org>
 <20160112004749.GT6588@sirena.org.uk>
 <20160112011904.GC7690@lunn.ch> <4004455.tVDpSpUXxo@wuerfel>
Message-ID: <20160112180223.GA6588@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 12, 2016 at 05:29:40PM +0100, Arnd Bergmann wrote:
> On Tuesday 12 January 2016 02:19:04 Andrew Lunn wrote:

> > When i played with this, i added a reschedule point at the end of the
> > drivers transfer_one_message() function, to see if that would help. It
> > did not, which is why i made a guess it has something to do with a
> > lock.

> Can you try using usleep_range() instead of udelay()? It might also

Oh, indeed - should've thought of that!

> be worth trying what the actual delay is for each byte to see if a
> longer sleep time would help, but I guess that time is highly
> device specific.

I expect that the delay will depend on the clock speed of the SPI bus
which is system dependant.  Might actually be worth checking if the bus
is clocked excessively slowly.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160112/6a0c55c1/attachment.sig>
