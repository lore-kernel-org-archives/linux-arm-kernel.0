From: broonie@kernel.org (Mark Brown)
Date: Thu, 20 Jul 2017 11:06:46 +0100
Subject: next-20170720 build: 1 failures 4 warnings (next-20170720)
In-Reply-To: <E1dY4uu-0008Od-2S@optimist>
References: <E1dY4uu-0008Od-2S@optimist>
Message-ID: <20170720100645.de6v27yczsqptcij@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 20, 2017 at 07:26:32AM +0100, Build bot for Mark Brown wrote:

Today's -next fails to build an arm allmodconfig due to:

> 	arm-allmodconfig
> ../drivers/net/ethernet/mediatek/mtk_eth_soc.c:1685:8: error: unknown type name 'irqreturn_t'
> ../drivers/net/ethernet/mediatek/mtk_eth_soc.c:1694:9: error: 'IRQ_HANDLED' undeclared (first use in this function)
> ../drivers/net/ethernet/mediatek/mtk_eth_soc.c:1697:8: error: unknown type name 'irqreturn_t'
> ../drivers/net/ethernet/mediatek/mtk_eth_soc.c:1706:9: error: 'IRQ_HANDLED' undeclared (first use in this function)
> ../drivers/net/ethernet/mediatek/mtk_eth_soc.c:2475:8: error: implicit declaration of function 'devm_request_irq' [-Werror=implicit-function-declaration]

There's no obvious relevant change in the driver, some other header
change will have broken the implicit inclusion it's relying on.  I just
sent a patch.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170720/34b34975/attachment.sig>
