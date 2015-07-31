From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 31 Jul 2015 12:51:45 +0200
Subject: [PATCH] i2c: omap: fix bus recovery setup
In-Reply-To: <1436366127-24756-1-git-send-email-jlu@pengutronix.de>
References: <1436366127-24756-1-git-send-email-jlu@pengutronix.de>
Message-ID: <20150731105145.GH1522@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 08, 2015 at 04:35:27PM +0200, Jan Luebbe wrote:
> At least on the AM335x, enabling OMAP_I2C_SYSTEST_ST_EN is not enough to
> allow direct access to the SCL and SDA pins. In addition to ST_EN, we
> need to set the TMODE to 0b11 (Loop back & SDA/SCL IO mode select).
> Also, as the reset values of SCL_O and SDA_O are 0 (which means "drive
> low level"), we need to set them to 1 (which means "high-impedance") to
> avoid unwanted changes on the pins.
> 
> As a precaution, reset all these bits to their default values after
> recovery is complete.
> 
> Signed-off-by: Jan Luebbe <jlu@pengutronix.de>

Applied to for-current, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150731/5a1363c0/attachment.sig>
