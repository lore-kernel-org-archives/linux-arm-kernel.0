From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Mon, 16 Aug 2010 14:22:16 +0200
Subject: [PATCH 1/3] dmaengine: add possibility for cyclic transfers
In-Reply-To: <1281956870-12463-2-git-send-email-s.hauer@pengutronix.de>
References: <1281956870-12463-1-git-send-email-s.hauer@pengutronix.de>
	<1281956870-12463-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <AANLkTi=3OYmuPUnBGimGTiGUbh32KDPyoXubvXJZAR99@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/8/16 Sascha Hauer <s.hauer@pengutronix.de>:

> Cyclic transfers are useful for audio where a single buffer divided
> in periods has to be transfered endlessly until stopped. After being
> prepared the transfer is started using the dma_async_descriptor->tx_submit
> function. dma_async_descriptor->callback is called after each period.
> The transfer is stopped using the DMA_TERMINATE_ALL callback.
> While being used for cyclic transfers the channel cannot be used
> for other transfer types.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>

Looks good to me.
Acked-by: Linus Walleij <linus.walleij@stericsson.com>

Yours,
Linus Walleij
