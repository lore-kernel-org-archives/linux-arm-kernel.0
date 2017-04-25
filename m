From: broonie@kernel.org (Mark Brown)
Date: Tue, 25 Apr 2017 11:31:13 +0100
Subject: [PATCH RFC 0/5] *** SPI Slave mode support ***
In-Reply-To: <CAMuHMdXa_O6RsqUciiNWQ0Zp6dniS47AUmPN9UWAWitP0csx=Q@mail.gmail.com>
References: <1492085644-4195-1-git-send-email-jiada_wang@mentor.com>
 <20170413125929.dygodgj6c35ydh5p@sirena.org.uk>
 <CAMuHMdUm=90ddNWM5KWqT+W0hqZ-QO6vPHj5OisbYquDYq1ZmA@mail.gmail.com>
 <58F06092.9080409@mentor.com>
 <CAMuHMdXa_O6RsqUciiNWQ0Zp6dniS47AUmPN9UWAWitP0csx=Q@mail.gmail.com>
Message-ID: <20170425103113.lxpwoq6sbxvg3ihl@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 24, 2017 at 12:55:21PM +0200, Geert Uytterhoeven wrote:
> On Fri, Apr 14, 2017 at 7:39 AM, Jiada Wang <jiada_wang@mentor.com> wrote:

> > Our use case is to use spidev as an interface to communicate with external
> > SPI master devices.
> > meanwhile the SPI bus controller can also act as master device to send data
> > to other
> > SPI slave devices on the board.

> That sounds a bit hackish to me. SPI was never meant to be a multi-master bus.
> While it can be done, you will need external synchronization (signals) to
> avoid conflicts between the SPI masters.

> > I found in your implementation, SPI bus controller is limited to either work
> > in master mode or
> > slave mode, is there any reasoning to not configure SPI mode based on SPI
> > devices use case?

> If you really need both master and slave support, you can use 2 subnodes
> in DT, the first representing the master, the second the slave.

> Mark, what's your opinion about this?

That sounds like a mess...   we *could* put the slave flag on the device
rather than the controller I guess but there's also going to need to be
something representing whatever avoids collisions on the bus somewhere.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170425/6c1fbd80/attachment.sig>
