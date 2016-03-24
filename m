From: broonie@kernel.org (Mark Brown)
Date: Thu, 24 Mar 2016 11:23:08 +0000
Subject: [PATCH v2] spi: orion.c: Add direct access mode
In-Reply-To: <56F37EFF.2090605@denx.de>
References: <20160322173546.40d24cc2@free-electrons.com>
 <56F17684.2010307@denx.de> <20160323113316.GH2566@sirena.org.uk>
 <56F2852C.5010006@denx.de> <20160323125448.GM2566@sirena.org.uk>
 <56F295E1.4030505@denx.de> <20160323132732.GN2566@sirena.org.uk>
 <56F2D19A.7020604@denx.de> <20160323183952.GK5250@lunn.ch>
 <56F37EFF.2090605@denx.de>
Message-ID: <20160324112308.GY2566@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 24, 2016 at 06:45:35AM +0100, Stefan Roese wrote:

> Right. It is of course possible to use this direct mode to access
> SPI flash. Its just not the way how the SPI MTD driver uses the
> SPI controller. All information that is written to the SPI flash
> (e.g. commands, addresses) are passed as plain tx-data in the SPI
> message to the SPI controller. And it would be not easy to detect
> commands / addresses vs. "real data" in this orion SPI driver
> to put these values into the specific registers.

We now have extensions for passing commands through directly (see
spi_flash_read()).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160324/269ea661/attachment.sig>
