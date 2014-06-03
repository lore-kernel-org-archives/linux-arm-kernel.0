From: broonie@kernel.org (Mark Brown)
Date: Tue, 3 Jun 2014 10:45:37 +0100
Subject: [PATCH 2/3] arm: tegra: enable igb, stmpe, i2c chardev, spidev,
 lm95245, pwm leds
In-Reply-To: <538D64FD.2010909@ziswiler.com>
References: <c5522b0efcbfc7690dcde6aaf78b9dd568f99604.1401665237.git.marcel@ziswiler.com>
 <39a8704a4c8170d6b0620a1e5e44042eae6d8810.1401665237.git.marcel@ziswiler.com>
 <538CA24B.1010602@wwwdotorg.org> <538CA635.4050502@ziswiler.com>
 <20140602221627.GP31751@sirena.org.uk>
 <538D64FD.2010909@ziswiler.com>
Message-ID: <20140603094537.GQ31751@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 03, 2014 at 08:02:37AM +0200, Marcel Ziswiler wrote:
> On 06/03/2014 12:16 AM, Mark Brown wrote:

> >Your DT is broken if it's got a "spidev" node in it, you should be
> >describing the hardware not the Linux implementation of the software.
> >It would be really nice if we had a good way of handling this but we
> >don't yet.

> I strongly disagree, it almost perfectly describes the hardware. Unlike on
> I2c where modelling a bus is enough to allow generic user space access
> unfortunately on SPI this is not enough as it requires a specific
> chip-select as well. This is exactly what spidev does and maps to our
> hardware perfectly which has one dedicated chip-select per SPI bus on a
> dedicated header which allows our customers out-of-the-box spidev user space
> access to almost any SPI device connected to those buses just like with
> i2c-devs on I2C buses.

When you say "generic user space access" you are describing a specific
detail of how this device happens to be controlled with your software.
This is not a description of your hardware, it is a description of how
it is controlled with your current software.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140603/c2e171d6/attachment.sig>
