From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Mon, 16 Aug 2010 14:27:15 +0200
Subject: [PATCH 1/3] dmaengine: add possibility for cyclic transfers
In-Reply-To: <19561.10098.732048.877464@ipc1.ka-ro>
References: <1281956870-12463-1-git-send-email-s.hauer@pengutronix.de>
	<1281956870-12463-2-git-send-email-s.hauer@pengutronix.de>
	<19561.10098.732048.877464@ipc1.ka-ro>
Message-ID: <AANLkTi=otwukcL2RM3P=hdAgzY+QDv99abQh4QXtVuqo@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/8/16 Lothar Wa?mann <LW@karo-electronics.de>:

> Why not implement this feature using cyclic SG lists (created with
> sg_chain())? This would give you endless DMA transfers without any
> special DMA API extensions.

That would be elegant...

The driver will have to detect that the sglist is chained like an
ouroboros to program the DMAC apropriately, is is easy to
detect if an sglist is chained onto itself?

Yours,
Linus Walleij
