From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 11 Apr 2012 17:05:48 +0200
Subject: [PATCH] mmc: remove linux/blkdev.h include from host drivers
In-Reply-To: <1334084783-3572-1-git-send-email-mad_soft@inbox.ru>
References: <1334084783-3572-1-git-send-email-mad_soft@inbox.ru>
Message-ID: <4F859DCC.6040307@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dmitry,

Le 04/10/2012 09:06 PM, Dmitry Artamonow a ?crit :
> None of mmc host drivers using linux/blkdev.h header
> really need anything from it. The slight exception is
> atmel-mci, which uses blkdev.h only because it indirectly
> pulls asm/cacheflush.h
>
> So remove any inclusion of blkdev.h - it should also fix
> build errors of dw_mmc and atmel-mci drivers when
> CONFIG_BLOCK is disabled, like following:
> ------------------------------------------------------
> In file included from drivers/mmc/host/dw_mmc.c:14:0:
> include/linux/blkdev.h:1408:42: warning: ?struct task_struct? declared inside parameter list [enabled by default]
> include/linux/blkdev.h:1408:42: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]
> include/linux/blkdev.h:1412:51: warning: ?struct task_struct? declared inside parameter list [enabled by default]
> include/linux/blkdev.h:1417:1: error: unknown type name ?bool?
> include/linux/blkdev.h:1417:48: warning: ?struct task_struct? declared inside parameter list [enabled by default]
> include/linux/blkdev.h: In function ?blk_needs_flush_plug?:
> include/linux/blkdev.h:1419:9: error: ?false? undeclared (first use in this function)
> include/linux/blkdev.h:1419:9: note: each undeclared identifier is reported only once for each function it appears in
> make[1]: *** [drivers/mmc/host/dw_mmc.o] Error 1
> make: *** [drivers/mmc/host/dw_mmc.o] Error 2
> ------------------------------------------------------
>
> Cc: Ludovic Desroches<ludovic.desroches@atmel.com>
> Cc: Pavel Pisa<ppisa@pikron.com>
> Cc: Sascha Hauer<s.hauer@pengutronix.de>
> Cc: Will Newton<will.newton@imgtec.com>
> Signed-off-by: Dmitry Artamonow<mad_soft@inbox.ru>
> ---
>
>   drivers/mmc/host/at91_mci.c  |    1 -
>   drivers/mmc/host/atmel-mci.c |    2 +-

Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Thanks for your patch.

Regards

Ludovic
