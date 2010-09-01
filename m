From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 1 Sep 2010 17:24:18 +0200
Subject: PrimeCell generic DMA v10
Message-ID: <1283354665-8673-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is	the tenth iteration of this patchset...

Now DMA	is working nicely on the following platforms and
PrimeCells:

- U300 PL011, PL022, PL180
- U8500	PL011, PL022, PL180
- RealView PB11MPCore PL011, PL022

PL180 (MMC) is not working with	the MMC	and DMA, I haven't
drilled	into why, could	be some	FIFO overflow or similar.
I think	DMA could actually be activated	for all	the RealViews
with a working DMA controller (EB, PB11MPCore, PBA8 and PBX)
but since I cannot test them I left them out of	the patch set.

I ran some serious stress tests	on the PB11MPCore, with	two
threads	submitting DMA memcpy jobs while making	transfers
on PL011 and PL022 simultaneously, no problems.

I read up on DMA-API and proofread all three drivers with
that in	mind, but I cannot find	any more misuses of the
API. (The latest unecessary sync call in PL022 that Russell
found is removed.)

The compilation	problem	Grant saw on the PL022 driver I	have
*still*	not been able to reproduce so I	am in the blue on
this one. It compiles nicely for U300, U8500 and RealView.
I need help if there is	still problems with this.

Yours,
Linus Walleij
