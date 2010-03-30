From: linus.walleij@stericsson.com (Linus WALLEIJ)
Date: Tue, 30 Mar 2010 11:57:12 +0200
Subject: [PATCH 0/5] ARM: PrimeCell DMA patches v4
In-Reply-To: <1269905728-5452-1-git-send-email-linus.walleij@stericsson.com>
References: <1269905728-5452-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CEE6BB42CAD6E947908279175AF8470A039B48CC@EXDCVYMBSTM006.EQ1STM.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Self]

> This is a fourth iteration of the PrimeCell DMA API on top of the
> generic DMA devices (sibling to the DMA engine). It's based on
> the suggestion from Russell to try and define a specific extension
> subset for DMA devices.

Russell & Grant can you give some hint on the direction you
see for this patch set?

The problem we're facing is that next I will start adding DMA
support for the U8500 and the MMCI derivate found in that platform
doesn't *have* a PIO IRQ, which means the system cannot even
boot without some solid DMA framework in place. (It is currently
unbootable from the released kernels.)

So unless there is some outstanding issue with this approach
we pretty much need this now to keep working on mainlining
the U8500.

I would very much like to have the DMA patches for PrimeCell
support pushed through Dan's tree, but that requires your ACKs
of course, and it will inevitably collide with other PrimeCell
patches for the next merge window (many submitted by myself
admittedly).

I can feed all the PrimeCell stuff to Dan if all agree that this
is a good approach. Another approach is to apply the latest
patches from Dan's tree to ARM and SPI alike and then feed
the PrimeCell stuff through the ARM tree.

Yours,
Linus Walleij
