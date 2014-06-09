From: marcel@ziswiler.com (Marcel Ziswiler)
Date: Tue, 10 Jun 2014 00:16:13 +0200
Subject: [PATCH 2/3] arm: tegra: enable igb, stmpe, i2c chardev, spidev,
 lm95245, pwm leds
In-Reply-To: <20140604111755.GG2520@sirena.org.uk>
References: <c5522b0efcbfc7690dcde6aaf78b9dd568f99604.1401665237.git.marcel@ziswiler.com>
 <39a8704a4c8170d6b0620a1e5e44042eae6d8810.1401665237.git.marcel@ziswiler.com>
 <538CA24B.1010602@wwwdotorg.org> <538CA635.4050502@ziswiler.com>
 <20140602221627.GP31751@sirena.org.uk> <538D64FD.2010909@ziswiler.com>
 <20140603094537.GQ31751@sirena.org.uk> <538EBACB.70100@ziswiler.com>
 <20140604111755.GG2520@sirena.org.uk>
Message-ID: <5396322D.6030003@ziswiler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/04/2014 01:17 PM, Mark Brown wrote:
> You're saying you're controlling it from userspace.  This is a
> particular detail of what you are doing in your system.  You happen to
> want to control the devices you are hanging off the system with
> userspace drivers but that's just what you're doing right now.

Sorry, I don't get it. Yes, spidev is to control stuff from user space 
just like i2c-dev however bad that might sound.

> No, that's in the controller node - the chip selects are described
> there.  The child node references a chip select number that the master
> has and describes what's connected to that chip select.

Well, unfortunately SPI without any chip select is just plain simply 
useless. It won't work.

> It's a perfectly fine way of controlling things from userspace if that's
> a sensible way of controlling devices but that does not mean you should
> describe it in the device tree in that fashion.

Only that without describing such a chip select in the device tree 
spidev won't ever work.

I don't see us reaching any consensus here therefore I retreat. I will 
re-submit the whole thing without spidev however sad having to see that 
useful feature being dropped.
