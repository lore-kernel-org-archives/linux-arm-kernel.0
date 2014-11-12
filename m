From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 12 Nov 2014 09:53:45 +0100
Subject: [PATCH 3/4] ARM: shmobile: rcar-gen2: Add CA7 arch_timer
 initialization for r8a7794
In-Reply-To: <20141111235954.GA12594@verge.net.au>
References: <cover.1415058939.git.horms+renesas@verge.net.au>
 <CAMuHMdUek9RA-tpVJbXKx1MENk47-E2s+437+SYNR9KbaO62dQ@mail.gmail.com>
 <20141111235954.GA12594@verge.net.au>
Message-ID: <2020527.4axRFYCiLW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 November 2014 08:59:55 Simon Horman wrote:
> > > From 8bf0a4cae3137411498ff23ca46f693e4c22a25b Mon Sep 17 00:00:00 2001
> > > From: Arnd Bergmann <arnd@arndb.de>
> > > Date: Tue, 11 Nov 2014 16:36:50 +0100
> > > Subject: [PATCH] ARM: shmobile: always build rcar setup for armv7
> > >
> > > In a combined ARMv6/v7 kernel, the setup-rcar-gen2.c cannot
> > > currently be compiled correctly because it uses the isb
> > > instruction that is not available on ARMv6. Adding the
> > > -march=armv7-a flag lets the compiler know that it is safe
> > > to build this file for ARMv7.
> > >
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > Thanks, this is a better solution than "[RFT] ARM: shmobile: rcar-gen2:
> > Fix build breakage" (https://lkml.org/lkml/2014/10/31/338).
> > 
> > Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Agreed.
> 
> Acked-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Arnd, what is the best way to get this patch merged?
> Do you plan to take it or should I?

I believe the problem only exists in your tree at the moment, not in arm-soc,
so please apply it on top of the branch that introduced the build error
before sending it to arm-soc. If you have already sent a pull request
but we haven't taken it yet, send an updated pull request that adds
this patch.

	Arnd
