From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 29 Nov 2011 22:39:10 -0200
Subject: does non-continuous RAM means I need to select the sparse memory
 model?
In-Reply-To: <20111129203010.GA26618@pengutronix.de>
References: <20111129203010.GA26618@pengutronix.de>
Message-ID: <CAOMZO5DX_ZvCOu+pqZpJ7Ni2B=qmSFCZTHnuzKt==OsBsJZH=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

2011/11/29 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Hello,
>
> I'm currently working on a new arch port and my current machine has RAM
> at 0x10000000 and 0x80000000. So there is a big hole between the two
> banks. When selecting the sparse memory model it works, but when
> selecting flat the machine runs into a BUG in mark_bootmem() called by
> free_unused_memmap() to free the space between the two banks.

My understanding is that you have to select ARCH_HAS_HOLES_MEMORYMODEL.

> Is that expected (meaning I cannot use the flat model)? I currently
> don't have another machine handy that has >1 memory back to test that.

In case you have access to a MX35PDK you can try on this board as it does have
the memory hole.

Regards,

Fabio Estevam
