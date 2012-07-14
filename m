From: paul@pwsan.com (Paul Walmsley)
Date: Sat, 14 Jul 2012 11:54:52 -0600 (MDT)
Subject: [PATCH] ARM: OMAP3: clockdomain: fix accidental duplicate
 registration
In-Reply-To: <20120714085257.GB6522@atomide.com>
References: <alpine.DEB.2.00.1207120448120.25585@utopia.booyaka.com>
 <87394wg97u.fsf@ti.com> <20120713064713.GI1122@atomide.com>
 <20120714085257.GB6522@atomide.com>
Message-ID: <alpine.DEB.2.00.1207141150340.3876@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 14 Jul 2012, Tony Lindgren wrote:

> As the tmp-merge branch has other branches and never goes upstream, the
> commit should say:
> 
> Commit 472fd5401561f94698f4c8f9dbbbfbf76ab55626 (Merge branch 'cleanup-hwmod'
> into cleanup)... So I've updated the patch and applied it into l-o master.

Thanks for fixing it.

> The patch seems to produce a new warning against arm soc tree 
> next/cleanup branch:
> 
> warning: ?mpu_3xxx_clkdm? defined but not used
> 
> Paul, care to check if a change is needed for the arm soc tree
> next/cleanup branch version of this patch?

arm-soc next/cleanup branch doesn't include commit 16e5e2c4 ("ARM: OMAP 
AM35x: clockdomain data: Fix clockdomain dependencies").  So that patch 
won't apply there, and the copy of mach-omap2/clockdomains3xxx_data.c in 
that branch is clean.


- Paul
