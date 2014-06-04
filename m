From: broonie@kernel.org (Mark Brown)
Date: Wed, 4 Jun 2014 12:17:55 +0100
Subject: [PATCH 2/3] arm: tegra: enable igb, stmpe, i2c chardev, spidev,
 lm95245, pwm leds
In-Reply-To: <538EBACB.70100@ziswiler.com>
References: <c5522b0efcbfc7690dcde6aaf78b9dd568f99604.1401665237.git.marcel@ziswiler.com>
 <39a8704a4c8170d6b0620a1e5e44042eae6d8810.1401665237.git.marcel@ziswiler.com>
 <538CA24B.1010602@wwwdotorg.org> <538CA635.4050502@ziswiler.com>
 <20140602221627.GP31751@sirena.org.uk>
 <538D64FD.2010909@ziswiler.com>
 <20140603094537.GQ31751@sirena.org.uk>
 <538EBACB.70100@ziswiler.com>
Message-ID: <20140604111755.GG2520@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 04, 2014 at 08:20:59AM +0200, Marcel Ziswiler wrote:
> On 06/03/2014 11:45 AM, Mark Brown wrote:

> >When you say "generic user space access" you are describing a specific
> >detail of how this device happens to be controlled with your software.

> No, not at all. In fact I did not even specify neither the exact type of
> device apart from it being a SPI device nor any property of the software
> apart from the generic user space access thereof implemented in the Linux

You're saying you're controlling it from userspace.  This is a
particular detail of what you are doing in your system.  You happen to
want to control the devices you are hanging off the system with
userspace drivers but that's just what you're doing right now.

> kernel. I really don't see any difference to i2c chardev which is already
> enabled in multi_v7_defconfig.

That does not require explicit registration as the device driver for the
device in order to be used.

> >This is not a description of your hardware, it is a description of how
> >it is controlled with your current software.

> Sorry, but I really don't know what you are referring to. It's a pure
> hardware description of some pins being the SPI bus namely MISO/MOSI and the
> clock plus an accompanying chip-select pin.

No, that's in the controller node - the chip selects are described
there.  The child node references a chip select number that the master
has and describes what's connected to that chip select.

> I fear for some reason or another you have some affinity against spidev
> which strikes me odd. Admittedly it is not perfect but it is the only
> generic SPI user space access currently implemented in the Linux kernel and
> so far did its job perfectly for many of our customers.

It's a perfectly fine way of controlling things from userspace if that's
a sensible way of controlling devices but that does not mean you should
describe it in the device tree in that fashion.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140604/93c068c6/attachment.sig>
