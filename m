From: tony@atomide.com (Tony Lindgren)
Date: Mon, 24 Sep 2012 09:19:45 -0700
Subject: linux-next: manual merge of the arm-soc tree with the
 omap_dss2 tree
In-Reply-To: <1348492306.2361.48.camel@deskari>
References: <20120924195305.588277e94ce701abc5e5a6c5@canb.auug.org.au>
 <201209241243.39462.arnd@arndb.de>
 <1348492306.2361.48.camel@deskari>
Message-ID: <20120924161944.GC28835@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [120924 06:12]:
> Hi Arnd,
> 
> On Mon, 2012-09-24 at 12:43 +0000, Arnd Bergmann wrote:
> > On Monday 24 September 2012, Stephen Rothwell wrote:
> > > Today's linux-next merge of the arm-soc tree got a conflict in
> > > drivers/video/omap/lcd_ams_delta.c between commit 9586778de558 ("OMAPFB1:
> > > remove unnecessary includes") from the  tree and commit e27e35ec735f
> > > ("ARM: OMAP1: Move board-ams-delta.h from plat to mach") from the arm-soc
> > > tree.
> > > 
> > > The latter removed a superset of the former (as far as include files is
> > > concerned), so I used that and can carry the fix as necessary (no action
> > > is required).
> > > 
> > 
> > Hi Stephen,
> > 
> > I looked at all your reports and your fixes are looking good to me.
> > 
> > I'm already building all ARM defconfigs now and have fixup patches for the
> > instances that went wrong or introduced new warnings, I'll do that again
> > on top of today's linux-next tree.
> > 
> > The merge window is going to be fun with all those conflicts, but I don't
> > have a better idea either.
> 
> If there's a stable branch for the OMAP platform changes, I could merge
> it to omapdss tree and fix the conflicts. But if I've understood right,
> Linus doesn't really like merges just for the sake of fixing conflicts.
> 
> So far all the omapdss conflicts seem trivial, though.

Trivial ones should be OK, but maybe you find something
minimal with the following to find tags that you can pull
into your branch make things easier:

$ git log --pretty=oneline --merges v3.6-rc7..arm-soc/for-next arch/arm/*omap*/* | grep "Merge tag" | grep omap

Regards,

Tony
