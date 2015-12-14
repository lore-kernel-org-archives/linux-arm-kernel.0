From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Mon, 14 Dec 2015 22:34:04 +0200
Subject: [PATCH 0/2] arm: omap2: AM43xx: enable ARM TWD timer
Message-ID: <1450125246-17249-1-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now ARM TWD timer can be enabled for AM437x devices since all prerequisite
patches have been merged already [1] [2].

But before finally enable ARM TWD timer for UP AM437x devices - 
the Broadcast event source and infrustructure need to be enabled properly.
Otherwise CPUIdle will be broken.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-August/363989.html
[2] http://www.spinics.net/lists/linux-omap/msg123940.html
Felipe Balbi (1):
  arm: omap2: AM43xx: select ARM TWD timer

Grygorii Strashko (1):
  ARM: OMAP: am43xx: enable GENERIC_CLOCKEVENTS_BROADCAST

 arch/arm/mach-omap2/Kconfig | 2 ++
 arch/arm/mach-omap2/timer.c | 6 ++++++
 2 files changed, 8 insertions(+)

-- 
2.6.4
