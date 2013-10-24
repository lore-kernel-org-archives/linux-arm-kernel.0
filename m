From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 24 Oct 2013 18:10:40 +0000
Subject: [PATCH 0/2] ARM: OMAP: dmtimers improvements.
In-Reply-To: <20131024065536.16889.49902.stgit@notabene.brown>
References: <20131024065536.16889.49902.stgit@notabene.brown>
Message-ID: <448912EABC71F84BBCADFD3C67C4BE5291DD30@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry for top posting .... Probably we should move the dmtimer to drivers/misc or create drivers/timer/
This has been pending for quite some time now....

Tony, what you say ?
________________________________________
From: linux-arm-kernel [linux-arm-kernel-bounces at lists.infradead.org] on behalf of NeilBrown [neilb at suse.de]
Sent: Thursday, October 24, 2013 2:57 AM
To: Tony Lindgren; Russell King
Cc: Belisko Marek; linux-omap at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; Dr. H. Nikolaus Schaller
Subject: [PATCH 0/2] ARM: OMAP: dmtimers improvements.

I would like to use omap dmtimer for a PWM driver (for the backlight
on my display).
But there are two difficulties.

Unfortunately Jon Hunter (who has helped me with dmtimers before)
seems to have disappeared.  So I guess I get to do it myself :-)

Following two patches make dmtimers more usable.

1/ allow the counter to be set even when the timer isn't counting.
2/ move the include file to a more useful location

Any help you can provide in getting these fixes upstream would be appreciated.

Thanks,
NeilBrown

---

NeilBrown (2):
      ARM: OMAP2+: dmtimer: allow counter to be set at any time.
      ARM: OMAP: move dmtimer.h from plat-omap/include/plat to include/linux


 arch/arm/mach-omap1/pm.c                           |    2
 arch/arm/mach-omap1/timer.c                        |    2
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |    2
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |    2
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |    2
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |    2
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    2
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c         |    2
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |    2
 arch/arm/mach-omap2/timer.c                        |    2
 arch/arm/plat-omap/dmtimer.c                       |   11 -
 arch/arm/plat-omap/include/plat/dmtimer.h          |  415 --------------------
 drivers/media/rc/ir-rx51.c                         |    2
 drivers/pwm/pwm-omap.c                             |    2
 drivers/staging/tidspbridge/core/dsp-clock.c       |    2
 include/linux/omap-dmtimer.h                       |  415 ++++++++++++++++++++
 16 files changed, 434 insertions(+), 433 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/plat/dmtimer.h
 create mode 100644 include/linux/omap-dmtimer.h

--
Signature


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
