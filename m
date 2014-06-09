From: broonie@kernel.org (Mark Brown)
Date: Mon, 9 Jun 2014 23:57:07 +0100
Subject: [PATCH 2/3] arm: tegra: enable igb, stmpe, i2c chardev, spidev,
 lm95245, pwm leds
In-Reply-To: <5396322D.6030003@ziswiler.com>
References: <c5522b0efcbfc7690dcde6aaf78b9dd568f99604.1401665237.git.marcel@ziswiler.com>
 <39a8704a4c8170d6b0620a1e5e44042eae6d8810.1401665237.git.marcel@ziswiler.com>
 <538CA24B.1010602@wwwdotorg.org> <538CA635.4050502@ziswiler.com>
 <20140602221627.GP31751@sirena.org.uk>
 <538D64FD.2010909@ziswiler.com>
 <20140603094537.GQ31751@sirena.org.uk>
 <538EBACB.70100@ziswiler.com> <20140604111755.GG2520@sirena.org.uk>
 <5396322D.6030003@ziswiler.com>
Message-ID: <20140609225707.GB5099@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 10, 2014 at 12:16:13AM +0200, Marcel Ziswiler wrote:
> On 06/04/2014 01:17 PM, Mark Brown wrote:

> >You're saying you're controlling it from userspace.  This is a
> >particular detail of what you are doing in your system.  You happen to
> >want to control the devices you are hanging off the system with
> >userspace drivers but that's just what you're doing right now.

> Sorry, I don't get it. Yes, spidev is to control stuff from user space just
> like i2c-dev however bad that might sound.

There is absolutely nothing wrong with that.  What there is a problem
with is putting that implementation detail into a device tree, if
someone comes along and writes an in kernel driver for the same device
the device tree needs to continue to work without modification as it is
an ABI.

> >No, that's in the controller node - the chip selects are described
> >there.  The child node references a chip select number that the master
> >has and describes what's connected to that chip select.

> Well, unfortunately SPI without any chip select is just plain simply
> useless. It won't work.

I'm sorry but I'm not seeing how that follows on from what I said?

> >It's a perfectly fine way of controlling things from userspace if that's
> >a sensible way of controlling devices but that does not mean you should
> >describe it in the device tree in that fashion.

> Only that without describing such a chip select in the device tree spidev
> won't ever work.

Again I'm not sure how that follows.  To repeat, the chip selects are
described on the SPI controller and referenced by the child devices when
they are instantiated by chip select number.  Please refer to the SPI
bindings if this is unclear, or be specific in what is unclear.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140609/3e25535e/attachment.sig>
