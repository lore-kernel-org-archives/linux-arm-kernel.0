From: broonie@kernel.org (Mark Brown)
Date: Wed, 4 Jul 2018 15:32:07 +0100
Subject: [RFC net-next 15/15] net: lora: Add Semtech SX1301
In-Reply-To: <BY1PR02MB1114BC0F12654B1E7C614108E7410@BY1PR02MB1114.namprd02.prod.outlook.com>
References: <20180701110804.32415-1-afaerber@suse.de>
 <20180701110804.32415-16-afaerber@suse.de>
 <20180702161258.GA18744@sirena.org.uk>
 <4e06cc72-2092-70f3-c801-bf6e4c3cbec2@suse.de>
 <20180703145022.GA13744@sirena.org.uk>
 <809fc546-6012-37f3-9485-cfd8eaf99488@suse.de>
 <20180703153137.GB13744@sirena.org.uk>
 <3f6289f9-d345-39a7-f0dd-9d5fa7c86e82@suse.de>
 <20180704114355.GB11693@sirena.org.uk>
 <BY1PR02MB1114BC0F12654B1E7C614108E7410@BY1PR02MB1114.namprd02.prod.outlook.com>
Message-ID: <20180704143207.GD11693@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 04, 2018 at 01:41:42PM +0000, Ben Whitten wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> In my SX1257 driver currently the regmap is backed via SPI with
> devm_regmap_init_spi, please correct me if I am wrong but if I
> understand correctly this could be split out to regmap backed by SPI
> in the case of a direct host connection, and a regmap backed by the
> SX1301's regmapped strobing register interface, regmap_bus?

Yes.

> Is there a precedent to this I can examine?

There's lots of devices that provide both SPI and I2C, you'd just be
using a regmap_bus instead of the I2C one.  I can't recall an example of
the specific combination you're looking for though.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180704/9142e5f2/attachment.sig>
