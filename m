From: broonie@kernel.org (Mark Brown)
Date: Fri, 14 Mar 2014 10:22:23 +0000
Subject: [PATCH 3/3] spi: psdev: add passive serial driver
In-Reply-To: <20140314101907.GF4234@pengutronix.de>
References: <1394639617-26917-1-git-send-email-m.grzeschik@pengutronix.de>
 <1394639617-26917-4-git-send-email-m.grzeschik@pengutronix.de>
 <20140312163427.GV28112@sirena.org.uk>
 <20140314101907.GF4234@pengutronix.de>
Message-ID: <20140314102223.GR366@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 14, 2014 at 11:19:07AM +0100, Michael Grzeschik wrote:

> Second, the driver has "per se" nothing to do with SPI, beside it needs
> a clock and data line to transfer an image to the FPGA. (One way,
> therefor: passive). It needs to use some SPI controller to do that. Even
> the SPI Bitbang driver. Because of this, it depends on the SPI
> framework.

Lots of drivers use SPI but they sit in the relevant frameworks rather
than in the SPI framework.

> It is actually not more than that. I took the spidev character device
> driver as reference implementation. Any Idea where to put this driver
> instead.

Like I say somewhere where it sits with other FPGA programming stuff (if
that's what it does) would be my first thought.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140314/57c1f7d4/attachment-0001.sig>
