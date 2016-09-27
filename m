From: broonie@kernel.org (Mark Brown)
Date: Tue, 27 Sep 2016 09:00:36 -0700
Subject: next-20160927 build: 2 failures 4 warnings (next-20160927)
In-Reply-To: <E1bop0x-0001YK-4h@optimist>
References: <E1bop0x-0001YK-4h@optimist>
Message-ID: <20160927160036.y3ti3gzt4ebg2vyz@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 27, 2016 at 10:49:27AM +0100, Build bot for Mark Brown wrote:

-next is still failing to build an arm and arm64 allmodconfig due to:

> 	arm64-allmodconfig
> ERROR: "irq_set_parent" [drivers/mfd/tps65217.ko] undefined!

> 	arm-allmodconfig
> ERROR: "irq_set_parent" [drivers/mfd/tps65217.ko] undefined!

due to 262d5cc6ceb293 (mfd: tps65217: Add support for IRQs) since
irq_set_parent() isn't exported.  There was a fix posted adding the
export to the IRQ subsystem but it's still not been applied, the
function is being used in order to enable lazy IRQ disabling for
threaded interrupts:

   https://www.spinics.net/lists/arm-kernel/msg532864.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 455 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160927/0a361488/attachment.sig>
