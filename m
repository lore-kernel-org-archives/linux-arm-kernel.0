From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 3 Sep 2010 20:23:23 +0200
Subject: [PATCH V3] arm & sh: factorised duplicated clkdev.c
In-Reply-To: <AANLkTimRKCYYQmgwY0DHu5+e-ggT8grJbdjWFvUqTzH=@mail.gmail.com>
References: <1283431716-21540-1-git-send-email-plagnioj@jcrosoft.com>
	<1283434786-26479-1-git-send-email-plagnioj@jcrosoft.com>
	<AANLkTimRKCYYQmgwY0DHu5+e-ggT8grJbdjWFvUqTzH=@mail.gmail.com>
Message-ID: <20100903182323.GA17152@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

[added git ML to Cc:]

On Fri, Sep 03, 2010 at 07:18:43PM +0900, Magnus Damm wrote:
> On Thu, Sep 2, 2010 at 10:39 PM, Jean-Christophe PLAGNIOL-VILLARD
> <plagnioj@jcrosoft.com> wrote:
> > factorise some generic infrastructure to assist looking up struct clks
> > for the ARM & SH architecture.
> >
> > as the code is identical at 99%
> >
> > put the arch specific code for allocation as example in asm/clkdev.h
> >
> > Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > ---
> > v3:
> > ? ? ? ?wrong comment removed
> > ? ? ? ?headers fixed
> 
> [snip]
> 
> I can't apply this patch using GNU patch. I've tested 2.5.9 and 2.6.1
> from Gentoo.
> 
> Using --dry-run is fine, but omitting dry-run gives me:
> 
> ...
> patching file arch/arm/common/clkdev.c
> patching file arch/sh/include/asm/clkdev.h
> Hunk #1 FAILED at 1.
> Hunk #2 FAILED at 11.
> 2 out of 2 hunks FAILED -- saving rejects to file
> arch/sh/include/asm/clkdev.h.rej
> 
> I guess this is caused by the last "renaming" hunk, see below.
> 
> I thought these things were supposed to work out of the box...
Yes, they work out of the box, but only for people using git :-)

Maybe git-apply can be used instead of patch?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
