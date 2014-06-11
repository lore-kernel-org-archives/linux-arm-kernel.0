From: mina86@mina86.com (Michal Nazarewicz)
Date: Wed, 11 Jun 2014 10:24:55 +0200
Subject: [RFC PATCH 2/3] DMA,
 CMA: use general CMA reserved area management framework
In-Reply-To: <20140610024910.GB19036@js1304-P5Q-DELUXE>
References: <1401757919-30018-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1401757919-30018-3-git-send-email-iamjoonsoo.kim@lge.com>
 <xa1twqcyjx3z.fsf@mina86.com> <20140610024910.GB19036@js1304-P5Q-DELUXE>
Message-ID: <xa1t38fb3lbc.fsf@mina86.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 10 2014, Joonsoo Kim <iamjoonsoo.kim@lge.com> wrote:
> Without including device.h, build failure occurs.
> In dma-contiguous.h, we try to access to dev->cma_area, so we need
> device.h. In the past, we included it luckily by swap.h in
> drivers/base/dma-contiguous.c. Swap.h includes node.h and then node.h
> includes device.h, so we were happy. But, in this patch, I remove
> 'include <linux/swap.h>' so we need to include device.h explicitly.

Ack.

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +--<mpn@google.com>--<xmpp:mina86@jabber.org>--ooO--(_)--Ooo--
