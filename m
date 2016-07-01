From: broonie@kernel.org (Mark Brown)
Date: Fri, 1 Jul 2016 19:15:57 +0200
Subject: next-20160701 build: 2 failures 5 warnings (next-20160701)
In-Reply-To: <E1bIuIz-00085X-RP@optimist>
References: <E1bIuIz-00085X-RP@optimist>
Message-ID: <20160701171557.GB6247@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 01, 2016 at 10:00:09AM +0100, Build bot for Mark Brown wrote:

Today's -next fails to build am ARM allmodconfig due to:

> 	arm-allmodconfig
> ../drivers/net/ethernet/mediatek/mtk_eth_soc.c:1300:2: error: implicit declaration of function 'mtk_handle_irq' [-Werror=implicit-function-declaration]
> ../drivers/net/ethernet/mediatek/mtk_eth_soc.c:1300:25: error: subscripted value is neither array nor pointer nor vector

due to the recent changes to the interrupt handling code, the function
has been split into rx and tx functions but the NET_POLL_CONTROLLER code
hasn't been updated.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160701/a2744dde/attachment.sig>
