From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 28 Dec 2009 22:44:36 +0000
Subject: Ethernet in a cold climate / SMDK6410
In-Reply-To: <4B391941.6000906@warmcat.com>
References: <4B38FB80.9050609@warmcat.com>
	<20091228190009.GB14799@sirena.org.uk> <4B3901E3.20004@warmcat.com>
	<20091228192244.GD14799@sirena.org.uk>
	<4B390AC3.2060702@warmcat.com>
	<20091228202123.GA16524@sirena.org.uk>
	<4B391941.6000906@warmcat.com>
Message-ID: <20091228224435.GA23617@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 28, 2009 at 08:46:57PM +0000, Andy Green wrote:

> I would suggest that relying on (mysterious, changeable) bootloader to  
> set up stuff like nCS timing and which nCS would be a dependency that  
> would be good to avoid.  People are trying to use the dev board as a  
> basis for their own designs and they have to ship an actual  
> non-quantum-mist bootloader with that.

Like I say, I wasn't aware that these were soft configurable in the
first place - I'd never needed to look beyond the hookup of the device
in the Samsung kernel plus some detective work with the IRQ polarity
configuration in the driver since the board miswires it.  I do agree
that if these things are software configurable then we ought to be doing
it in the kernel, I strongly suspect that any setup done by the
bootloader is only being done when booting over the network.

>> It sounds like you've at least got a completely different bootloader (or
>> the source is highly misleading).  The other thing to check is which rev
>> of the board you have, there have been several revisions though I don't
>> recall any changes in the networking.

> Right I wrote Qi bootloader support for s3c6410.  This allows true SD  
> boot from SMDK.  "True SD boot" means that the bootloader itself is on  
> SD Card and is brought over into RAM by the CPU ROM, so there is nothing  
> to brick on the device itself.

Qi would be a massive step back for me in terms of usability
unfortunately - having to transfer things to an SD card to boot them
would add a lot to my edit, compile run cycle compared to netboot.
