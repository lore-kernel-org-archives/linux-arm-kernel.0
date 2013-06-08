From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 7 Jun 2013 18:26:37 -0600
Subject: [PATCH 03/14] bus: mvebu-mbus: Introduce device tree binding
In-Reply-To: <201306072315.50390.arnd@arndb.de>
References: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <201306072153.03855.arnd@arndb.de>
 <20130607200956.GB9010@obsidianresearch.com>
 <201306072315.50390.arnd@arndb.de>
Message-ID: <20130608002637.GA2391@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 07, 2013 at 11:15:50PM +0200, Arnd Bergmann wrote:

> > The mbus driver should never read or write this register.
> 
> That is not a hard requirement, right? I guess based on the
> recent discussion about the 0xd0 or 0xf1 window, there may
> actually be good reasons to reassign it, although I agree
> that we shouldn't bother with implementing that for now, as
> it's not a simple or urgent problem.

Yes, exactly.

To be meaningfull any re-assignment probably has to go along with a
SDRAM remap as well, which is tricky to impossible to do when you are
already running from SDRAM.

> > Doesn't really matter which is picked, as far as I can tell, though
> > maybe the 01 option is best, leading to:
> > 
> >   IIAAssss 00oooooo
> > 
> > Where:
> >    == 0 means I/A are:
> >    == 1 means internal regs block
> > 
> > Which is pretty tidy..
> 
> Ok, thanks for the explanation. I think this is a good representation.
> The other idea I raised in my previous mail would end up with something
> like
> 
>  SIIAA000 00oooooo
> 
> with 'S' having the inverted meaning of your 's', so '0' actually
> refers to the internal regs as in Ezequiel's current code.
> 
> I'm fine with either representation though.

Right, it doesn't really matter, Ezequiel should pick whatever he
likes, as long as the encoding is fully described in the binding
document (Ezequiel, feel free to crib my text), and the 'special' IDs
don't overlap with potentially valid target ids (ie don't use 0 ==
internal regs).

Jason
