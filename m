From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Tue, 7 Jun 2011 12:17:01 +0100
Subject: [RFC PATCH] KMS support for i.MX51/53
In-Reply-To: <1307443550-25549-1-git-send-email-s.hauer@pengutronix.de>
References: <1307443550-25549-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20110607121701.71cdd06e@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Currently I don't use any sophisticated memory allocater like GEM
> or similar. I helped myself with simple dma_alloc where needed. At

GEM is actually pretty sane when you get your head around it a spot. The
main thing it took me a bit of time to get my head around is that it
allocates backing memory and handles but it doesn't allocate address
space on the card side.

For a minimal GEM take a look at drivers/staging/gma500/psb_gem.c. As I
need to use a GTT and allocate address space I also use a standard Linux
resource struct. If you just need to grab RAM and don't care about
address spaces then you are well away except for getting console support I
imagine.

The GMS500 one has no magic interfaces for things like swapping objects,
as the card is just using it for 2D frame buffer objects so hopefully is
a bit easier to follow than the full works.

Alan
