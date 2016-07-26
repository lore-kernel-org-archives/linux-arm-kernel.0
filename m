From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Jul 2016 14:44:02 +0200
Subject: next build: 74 warnings 0 failures (next/next-20160726)
In-Reply-To: <57972885.4f82620a.b4f01.70ab@mx.google.com>
References: <57972885.4f82620a.b4f01.70ab@mx.google.com>
Message-ID: <4062168.TXYGYGtQKO@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, July 26, 2016 2:08:21 AM CEST Olof's autobuilder wrote:
> Warnings:
>       1 drivers/infiniband/core/cma.c:1242:12: warning: 'src_addr_storage.sin_addr.s_addr' may be used uninitialized in this function [-Wmaybe-uninitialized]
>       1 drivers/tty/serial/8250/8250_fintek.c:34:0: warning: "IRQ_MODE" redefined
>       2 drivers/clocksource/jcore-pit.c:277:187: warning: comparison of distinct pointer types lacks a cast
>       2 drivers/media/dvb-frontends/cxd2841er.c:3408:40: warning: 'carrier_offset' may be used uninitialized in this function [-Wmaybe-uninitialized]
>      34 drivers/ata/libata-scsi.c:3637:28: warning: suggest parentheses around comparison in operand of '&' [-Wparentheses]
>      34 drivers/ata/libata-scsi.c:3702:28: warning: suggest parentheses around comparison in operand of '&' [-Wparentheses]

The jcore-pit one is new, I've submitted fixes for that one, and had
older fixes for all the others. The infiniband warning is the only one
that is not a regression against 4.7.

Since there is now a very small set of remaining warnings, I plan to repost
them as a series until they are all merged.

	Arnd
