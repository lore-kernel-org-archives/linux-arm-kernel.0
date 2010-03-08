From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon,  8 Mar 2010 14:51:53 +0100
Subject: [PATCH 0/5] ARM: PrimeCell DMA patches v3
Message-ID: <1268056313-16292-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a third iteration of the PrimeCell DMA API on top of the
generic DMA devices (sibling to the DMA engine). It's based on
the suggestion from Russell to try and define a specific extension
subset for DMA devices.

Dan: if you prefer that any of these API:s go into the generic DMA
devices interface as optional calls or so, tell me and I'll
rewrite the patches with a DMA devices extension instead.

Now I have also implemented PL011 UART support so if you want to
scrutinize unreviewed material, go for patch number 4. The number
of extension API:s have gone from one to three. (See patch 1.)

I'm persisting on creating an interface on top of the DMA
devices since it is the best I can come up with for everone
else wanting to use DMA with these PrimeCells, the alternatives
as I see it would be to either:

Move the API extensions from <linux/amba/dma.h> to <plat/dma.h>
and rename config symbols accordingly, so the inserted DMA
code chunks will be for U300, Nomadik and Ux500 platforms only.
This means that PL011 carries a huge platform-specific #ifdef.
We will use DMA engine for COH 901 318 and also the Ux500 DMA
hardware named DMA40.

Or: Copy and fork mmci.c and amba-pl011.c into platform-specific
versions sharing much code with the original drivers. (Leading
to double bugfixing etc...)

None of the alternatives are very attractive, so I think this
is the most elegant solution for the time being, given that
other users like PL080 also can provide DMA engines. I think
this will be possible.

I will update the versions in the patch tracker soonish as
well unless there is some need of rewriting this.

Yours,
Linus Walleij
