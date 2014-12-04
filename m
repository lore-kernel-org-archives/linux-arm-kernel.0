From: balbi@ti.com (Felipe Balbi)
Date: Thu, 4 Dec 2014 11:03:53 -0600
Subject: [PATCH] arm: omap2: rx51-peripherals: fix build warning
In-Reply-To: <20141204150012.2fb75907@recife.lan>
References: <1417033655-32332-1-git-send-email-balbi@ti.com>
 <20141204152411.GF18045@saruman> <3261416.DL88JFJXUF@wuerfel>
 <20141204154835.GH18045@saruman>
 <20141204163930.GF2817@atomide.com>
 <20141204150012.2fb75907@recife.lan>
Message-ID: <20141204170353.GK18045@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Dec 04, 2014 at 03:00:12PM -0200, Mauro Carvalho Chehab wrote:
> Em Thu, 04 Dec 2014 08:39:31 -0800
> Tony Lindgren <tony@atomide.com> escreveu:
> 
> > * Felipe Balbi <balbi@ti.com> [141204 07:50]:
> > > Hi,
> > > 
> > > On Thu, Dec 04, 2014 at 04:41:13PM +0100, Arnd Bergmann wrote:
> > > > On Thursday 04 December 2014 09:24:11 Felipe Balbi wrote:
> > > > > On Wed, Nov 26, 2014 at 02:27:35PM -0600, Felipe Balbi wrote:
> > > > > > commit 68a3c04 ([media] ARM: OMAP2: RX-51: update
> > > > > > si4713 platform data) updated board-rx51-peripherals.c
> > > > > > so that si4713 could be easily used on DT boot, but
> > > > > > it ended up introducing a build warning whenever
> > > > > > si4713 isn't enabled.
> > > > > > 
> > > > > > This patches fixes that warning:
> > > > > > 
> > > > > > arch/arm/mach-omap2/board-rx51-peripherals.c:1000:36: warning: \
> > > > > > 	?rx51_si4713_platform_data? defined but not used [-Wunused-variable]
> > > > > >  static struct si4713_platform_data rx51_si4713_platform_data = {
> > > > > > 
> > > > > > Cc: Sebastian Reichel <sre@kernel.org>
> > > > > > Cc: Tony Lindgren <tony@atomide.com>
> > > > > > Cc: Hans Verkuil <hans.verkuil@cisco.com>
> > > > > > Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
> > > > > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > > > > 
> > > > > a gentle reminder on this one.
> > > > > 
> > > > 
> > > > Let me add my
> > > > 
> > > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > > > 
> > > > You didn't say who you expect to pick up the patch. I assume Mauro
> > > 
> > > patch author now decides who takes the patch ? That's new :-)
> 
> Well, for patches that cross subsystem boundaries, like this one,
> the best is to give a hint about whom you expect to pick it.
> 
> In this specific case, as commit 68a3c04 is in my tree, the best is
> to merge the patch on it, as the patch may not even apply at Tony's
> tree.

pointing to the commit that caused the problem really isn't enough ? The
commit short description (which is also on my commit log) clearly
mentions "[media]".

Anyway, I'll do that next time.

> > > > should take it because he took the patch that caused the problem,
> > > > but he might not be aware that he should look at this now.
> > > 
> > > He is in Cc, let's ask him :-)
> > 
> > Best that this one goes in along with the other si4713 patches
> > to avoid dependencies between trees:
> > 
> > Acked-by: Tony Lindgren <tony@atomide.com>
> 
> Thanks! I'll merge it via my tree.

tks

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141204/78c8be28/attachment.sig>
