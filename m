From: tony@atomide.com (Tony Lindgren)
Date: Wed, 29 Feb 2012 14:42:50 -0800
Subject: [PATCH] ARM: OMAP: id: Add missing break statement in
 omap3xxx_check_revision
In-Reply-To: <79CD15C6BA57404B839C016229A409A8317B7282@DBDE01.ent.ti.com>
References: <1327305407-19914-1-git-send-email-hvaibhav@ti.com>
 <20120127002543.GG29812@atomide.com>
 <79CD15C6BA57404B839C016229A409A8317B530C@DBDE01.ent.ti.com>
 <79CD15C6BA57404B839C016229A409A8317B7282@DBDE01.ent.ti.com>
Message-ID: <20120229224250.GT18901@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Hiremath, Vaibhav <hvaibhav@ti.com> [120129 23:59]:
> On Fri, Jan 27, 2012 at 11:02:01, Hiremath, Vaibhav wrote:
> > On Fri, Jan 27, 2012 at 05:55:43, Tony Lindgren wrote:
> > > * Vaibhav Hiremath <hvaibhav@ti.com> [120122 23:26]:
> > > > Add missing break statement in the function omap3xxx_check_revision.
> > > > 
> > > > The commit id 4390f5b2cb1f56 [ARM: OMAP: TI814X: Add cpu type macros
> > > > and detection support], removed the 'break' statement from the function
> > > > omap3xxx_check_revision(), resulting into wrong omap/cpu_revision
> > > > initialization for AM335x devices.
> > > 
> > > Looks like this is already fixed, can you please verify with
> > > v3.3-rc1?
> > > 
> > Tony,
> > 
> > I just looked at your linux-omap/master branch and 'break' statement is missing. So this patch is still required.
> > 
> > I can still see,
> > 
> > 394                 }
> > 395                 break;
> > 396         case 0xb944:
> > 397                 omap_revision = AM335X_REV_ES1_0;
> > 398                 cpu_rev = "1.0";
> > 399         case 0xb8f2:
> > 400                 switch (rev) {
> > 
> > 
> Tony,
> 
> Can this be merged? I can still see "break" statement missing in the latest
> linux-omap/master branch.

OK thanks applying into fixes for the -rc cycle.

Tony
