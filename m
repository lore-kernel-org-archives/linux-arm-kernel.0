From: broonie@kernel.org (Mark Brown)
Date: Wed, 20 May 2015 12:41:58 +0100
Subject: [RFC PATCH 1/4] spi: spidev: Add Google SPI flash compatible
 string
In-Reply-To: <555C6E51.5030601@collabora.co.uk>
References: <1432042454-19234-1-git-send-email-javier.martinez@collabora.co.uk>
 <1432042454-19234-2-git-send-email-javier.martinez@collabora.co.uk>
 <20150520101318.GB21577@sirena.org.uk>
 <555C5F65.7010204@collabora.co.uk>
 <20150520103746.GD21577@sirena.org.uk>
 <555C6E51.5030601@collabora.co.uk>
Message-ID: <20150520114158.GF21577@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 20, 2015 at 01:21:53PM +0200, Javier Martinez Canillas wrote:

> The ChromeOS user-space just uses flashrom to send a raw stream of bytes
> via spidev to the SPI NOR flash chip. There is drivers/mtd/spi-nor/spi-nor.c
> but AFAIU there are some limitations when interfacing the flash through
> the MTD layer, for example there isn't a way to set the SPI flash write
> protection through MTD. But I'll do some investigation before re-spinning
> the patches.

OK, that's a bit concerning - perhaps what's needed here is to extend
MTD and so on (if only to find some way for it to coexist with spidev
for the time being)?

> BTW, the other "rohm,dh2228fv" compatible string in spidev added by commit
> 8fad805bdc52 ("spi: spidev: Add Rohm DH2228FV DAC compatible string"), also
> does not have a documented DT binding so that should be fixed as well.

wv :)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150520/c77efa8f/attachment.sig>
