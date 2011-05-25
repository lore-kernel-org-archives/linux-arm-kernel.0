From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 25 May 2011 10:39:52 +0200
Subject: [PATCH 1/5] dmaengine: add ep93xx DMA support
In-Reply-To: <e6777eb9f7228ee1dadec1f0c9f16c3afc44c307.1306082097.git.mika.westerberg@iki.fi>
References: <cover.1306082097.git.mika.westerberg@iki.fi>
	<e6777eb9f7228ee1dadec1f0c9f16c3afc44c307.1306082097.git.mika.westerberg@iki.fi>
Message-ID: <BANLkTi=3z3kO5VEe2up8Mfm+bNXkY3baUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/5/22 Mika Westerberg <mika.westerberg@iki.fi>:

> The ep93xx DMA controller has 10 independent memory to peripheral (M2P)
> channels, and 2 dedicated memory to memory (M2M) channels. M2M channels can
> also be used by SPI and IDE to perform DMA transfers to/from their memory
> mapped FIFOs.

No so much a review comment as an observation: I opposed the merge of the
EP93xx SPI driver in drivers/spi/ep93xx_spi.c on the grounds that it was close
enough to amba-pl022.c that it could use that driver instead.

One of the arguments against was that you were going to do custom DMA
and stuff. Now you're using the DMAengine, so can you please reconsider
refactoring amba-pl022.c to suit your needs and you'll get DMA support for
free mor or less.

Yours,
Linus Walleij
