From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 29 Nov 2011 21:30:10 +0100
Subject: does non-continuous RAM means I need to select the sparse memory
 model?
Message-ID: <20111129203010.GA26618@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I'm currently working on a new arch port and my current machine has RAM
at 0x10000000 and 0x80000000. So there is a big hole between the two
banks. When selecting the sparse memory model it works, but when
selecting flat the machine runs into a BUG in mark_bootmem() called by
free_unused_memmap() to free the space between the two banks.

Is that expected (meaning I cannot use the flat model)? I currently
don't have another machine handy that has >1 memory back to test that.

This happens on 3.2-rc2 and with a port on 2.6.33 I don't need to select
sparse.

Best regards and thanks for any insight,
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
