From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 07 Jan 2014 16:05:43 +0100
Subject: [PATCH] scripts/kallsyms: filter symbols not in kernel address
 space
In-Reply-To: <CACVXFVNPcC+7Th-xfD24GiEat=FHMGKXh9Abc_othvR5pdLOYQ@mail.gmail.com>
References: <1382975339-25831-1-git-send-email-tom.leiming@gmail.com>
 <201401071512.34016.arnd@arndb.de>
 <CACVXFVNPcC+7Th-xfD24GiEat=FHMGKXh9Abc_othvR5pdLOYQ@mail.gmail.com>
Message-ID: <5082388.oRuzc7DqM3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 07 January 2014 22:33:24 Ming Lei wrote:
> On Tue, Jan 7, 2014 at 10:12 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Monday 28 October 2013, Ming Lei wrote:
> 
> We had posted two patches to address the problem, see below link:
> 
>    http://lists.scusting.com/index.php?t=msg&goto=1726509&S=Google

The patch "scripts/link-vmlinux.sh: only filter kernel symbols for arm"
has made it in now, which is good for all other architectures, but it
makes no difference  for nommu-arm, because CONFIG_PAGE_OFFSET is
still set.

The second patch from Jonathan Austin has not been applied yet, as of
today's linux-next, and it's exactly what I suggested. However it
won't work on ARM platforms that define their own PLAT_PHYS_OFFSET:
ebsa110, ep93xx, exynos, footbridge, integrator, iop13xx, ks8695,
omap1, realview, rpc, s5pv210 and sa1100. Fortunately these all have
MMUs, so in practice it won't hurt, but it doesn't seem correct.

	Arnd
