From: broonie@kernel.org (Mark Brown)
Date: Mon, 13 Feb 2017 11:30:53 +0000
Subject: [PATCH 1/8] spi: davinci: Use SPI framework to handle DMA mapping
In-Reply-To: <1486740584-17875-2-git-send-email-fisaksen@baylibre.com>
References: <1486740584-17875-1-git-send-email-fisaksen@baylibre.com>
 <1486740584-17875-2-git-send-email-fisaksen@baylibre.com>
Message-ID: <20170213113053.w53wfxugxtbitnn3@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 10, 2017 at 04:29:37PM +0100, Frode Isaksen wrote:

> Note that the dummy buffer used when doing one-way transfer, must
> still be mapped in this module.

No, the driver shouldn't be doing this - it should specify if it's
_MUST_RX and/or _MUST_TX and let the core handle it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170213/3bec4428/attachment.sig>
