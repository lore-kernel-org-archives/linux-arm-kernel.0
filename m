From: tony@atomide.com (Tony Lindgren)
Date: Sat, 14 Jul 2012 01:52:58 -0700
Subject: [PATCH] ARM: OMAP3: clockdomain: fix accidental duplicate
 registration
In-Reply-To: <20120713064713.GI1122@atomide.com>
References: <alpine.DEB.2.00.1207120448120.25585@utopia.booyaka.com>
 <87394wg97u.fsf@ti.com> <20120713064713.GI1122@atomide.com>
Message-ID: <20120714085257.GB6522@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [120712 23:52]:
> * Kevin Hilman <khilman@ti.com> [120712 10:55]:
> > Paul Walmsley <paul@pwsan.com> writes:
> > 
> > > Commit 3dd50d0545bd5a8ad83d4339f07935cd3e883271 ("Merge tag 
> > > 'omap-cleanup-for-v3.6' into tmp-merge") inadvertently caused a 
> > > clockdomain to be registered twice on OMAP3 boards.  This causes warnings 
> > > on boot, wild pointer dereferences, and PM regressions.  Fix the double 
> > > registration and add some clockdomain code to prevent this from happening 
> > > again.

As the tmp-merge branch has other branches and never goes upstream, the
commit should say:

Commit 472fd5401561f94698f4c8f9dbbbfbf76ab55626 (Merge branch 'cleanup-hwmod'
into cleanup)... So I've updated the patch and applied it into l-o master.

The patch seems to produce a new warning against arm soc tree next/cleanup
branch:

warning: ?mpu_3xxx_clkdm? defined but not used

Paul, care to check if a change is needed for the arm soc tree
next/cleanup branch version of this patch?

Tony
