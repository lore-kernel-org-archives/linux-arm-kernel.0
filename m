From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 28 Dec 2009 20:21:23 +0000
Subject: Ethernet in a cold climate / SMDK6410
In-Reply-To: <4B390AC3.2060702@warmcat.com>
References: <4B38FB80.9050609@warmcat.com>
	<20091228190009.GB14799@sirena.org.uk> <4B3901E3.20004@warmcat.com>
	<20091228192244.GD14799@sirena.org.uk>
	<4B390AC3.2060702@warmcat.com>
Message-ID: <20091228202123.GA16524@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 28, 2009 at 07:45:07PM +0000, Andy Green wrote:
> On 12/28/09 19:22, Somebody in the thread at some point said:

>> Yes, whatever was flashed on it when Samsung last had the board.  The
>> bootloader does explicitly say it's looking for the SMSC chip when
>> setting it up.

> I went and looked at the sources for that I got from Samsung, it talks  
> only about CS8900.

That's...  interesting.  To be honest I don't think I've ever seen the
source code for the bootloaders, but none of the SMDK boards I've had
have defaulted to using the CS8900 - I've never actually seen software
that talked to it to my knowledge, the Samsung bootloaders and kernels
were all using the SMSC chip and obviously that's what mainline has been
doing too.

>> I'm not sure what you mean by the "machine definition file" here?  The

> I meant mach-smdk6410.c, since it wants to configure Linux to use stuff  
> that has dependencies it doesn't control.  If it's going to claim  
> something is there at 0x18000000 for a particular machine then it's at  
> least arguable it should configure any soft prerequisites (nCS)  
> accordingly and document the ones out of its control.

Oh, sure - you were saying it should configure stuff and obviously most
of these things are completely out of scope for software which wasn't
very clear at all.  I quite frankly wasn't aware that there were any
relevant soft controls at all.

By the way, the other thing to watch out for with the Samsung boards is
that as well as the DIP switches there's a bunch of resistor fit options
that can be changed as well.

> I understand that you might be able to get that working and yet not  
> understand the intricacies of the dev board, and we're still ahead that  
> you managed to get anything working.

Right, and hopefully this is the sort of thing that Samsung are going to
be doing with their mainline work.

> My board is as shipped with the switches AFAIK except configured for SD  
> Card boot according to Samsung docs.

It sounds like you've at least got a completely different bootloader (or
the source is highly misleading).  The other thing to check is which rev
of the board you have, there have been several revisions though I don't
recall any changes in the networking.
