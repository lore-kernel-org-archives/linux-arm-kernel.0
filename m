From: broonie@kernel.org (Mark Brown)
Date: Tue, 23 Apr 2013 15:42:56 +0100
Subject: [PATCH 2/3] spi: s3c64xx: Added provision for dedicated cs pin
In-Reply-To: <1366614565-3743-3-git-send-email-ks.giri@samsung.com>
References: <1366614565-3743-1-git-send-email-ks.giri@samsung.com>
 <1366614565-3743-3-git-send-email-ks.giri@samsung.com>
Message-ID: <20130423144256.GP5019@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 22, 2013 at 12:39:24PM +0530, Girish K S wrote:
> From: Girish K S <girishks2000@gmail.com>
> 
> The existing driver supports gpio based /cs signal.
> For controller's that have one device per controller,
> the slave device's /cs signal might be internally controlled
> by the chip select bit of slave select register. They are not
> externally asserted/deasserted using gpio pin.

This doesn't build:

drivers/spi/spi-s3c64xx.c: In function 's3c64xx_get_slave_ctrldata':
drivers/spi/spi-s3c64xx.c:1023: error: 'sdd' undeclared (first use in this function)
drivers/spi/spi-s3c64xx.c:1023: error: (Each undeclared identifier is reported only once
drivers/spi/spi-s3c64xx.c:1023: error: for each function it appears in.)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130423/ab4c606f/attachment.sig>
