From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 30 Jan 2012 02:43:12 -0700
Subject: [PATCH 0/2] ARM: OMAP2+: PM: miscellaneous powerdomain-related
 improvements
Message-ID: <20120130093931.11027.31048.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series optimizes some of the powerdomain-related code in
arch/arm/mach-omap2/pm*, and fixes a bug or two.  These were noticed while
working on the functional powerstate code.

Rajendra and Santosh, if you have a spare moment, could you please
peek at the OMAP4 LOWPOWERSTATECHANGE part of the second patch?  It
makes sense to me in theory, but you both would probably know better
than I :-)

Kevin, want to take this series (assuming folks are happy with it) ?

Tested dynamic idle with and without CPUIdle, with and without
off-mode, on a Beagleboard 35xx.

This series is available via git at git://git.pwsan.com/linux-2.6 in
the branch "pm_cleanup_3.4".


- Paul

---

pm_cleanup_3.4
   text	   data	    bss	    dec	    hex	filename
6592771	 678492	5590684	12861947	 c441fb	vmlinux.orig
6592771	 678492	5590684	12861947	 c441fb	vmlinux.patched

Paul Walmsley (2):
      ARM: OMAP3: PM: remove superfluous calls to pwrdm_clear_all_prev_pwrst()
      ARM: OMAP2+: PM: clean up omap_set_pwrdm_state()


 arch/arm/mach-omap2/pm.c     |   39 +++++++++++++++++----------------------
 arch/arm/mach-omap2/pm34xx.c |    5 -----
 2 files changed, 17 insertions(+), 27 deletions(-)
