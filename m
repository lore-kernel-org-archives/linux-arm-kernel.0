From: tony@atomide.com (Tony Lindgren)
Date: Mon, 16 Jul 2012 01:36:09 -0700
Subject: [PATCH] ARM: OMAP3: clockdomain: fix accidental duplicate
 registration
In-Reply-To: <alpine.DEB.2.00.1207141150340.3876@utopia.booyaka.com>
References: <alpine.DEB.2.00.1207120448120.25585@utopia.booyaka.com>
 <87394wg97u.fsf@ti.com> <20120713064713.GI1122@atomide.com>
 <20120714085257.GB6522@atomide.com>
 <alpine.DEB.2.00.1207141150340.3876@utopia.booyaka.com>
Message-ID: <20120716083609.GG6522@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [120714 10:59]:
> On Sat, 14 Jul 2012, Tony Lindgren wrote:
> 
> > The patch seems to produce a new warning against arm soc tree 
> > next/cleanup branch:
> > 
> > warning: ?mpu_3xxx_clkdm? defined but not used
> > 
> > Paul, care to check if a change is needed for the arm soc tree
> > next/cleanup branch version of this patch?
> 
> arm-soc next/cleanup branch doesn't include commit 16e5e2c4 ("ARM: OMAP 
> AM35x: clockdomain data: Fix clockdomain dependencies").  So that patch 
> won't apply there, and the copy of mach-omap2/clockdomains3xxx_data.c in 
> that branch is clean.

Hmm well it seems that we should apply this fix into arm-soc next/cleanup
branch if that's where the mismerge happened? It seems the same mismerge
is there even without 16e5e2c4?

You patch applies into arm-soc next/cleanup with fuzz:

patching file arch/arm/mach-omap2/clockdomain.c
patching file arch/arm/mach-omap2/clockdomain.h
Hunk #1 succeeded at 82 (offset -4 lines).
patching file arch/arm/mach-omap2/clockdomains3xxx_data.c
Hunk #1 succeeded at 347 with fuzz 2 (offset -107 lines).

So that's why I'm wondering if it needs some changes.

Regards,

Tony
