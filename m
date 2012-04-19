From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 18 Apr 2012 19:20:29 -0700
Subject: [PATCH 0/7] ARM: S5P: moving plat-s5p stuff into plat-samsung
Message-ID: <1334802036-16768-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patches move plat-s5p stuff into plat-samsung for keep just one
plat directory, plat-samsung for Samsung stuff. Actually, it includes
small things for common s5p and there is no problem this moving.
Of course, I'm working on removing plat-s3c24xx and will be submitted
before v3.4 release.

NOTE, now the plat-s5p directory which is including Kconfig and dummy
Makefile is not removed yet because need to cleanup CONFIG_PLAT_S5P
and will be removed soon.

The following changes since commit b1a797eb3759e1c166561c8bc035dbf3d40b8710:

  Merge branch 'next/cleanup-samsung-iommu' into topic/cleanup-plat-s5p (2012-04-16 21:13:20 -0700)

[PATCH 1/7] ARM: SAMSUNG: move clock part for common s5p into plat-samsung
[PATCH 2/7] ARM: SAMSUNG: move interrupt part for common s5p into plat-samsung
[PATCH 3/7] ARM: SAMSUNG: move pm part for common s5p into plat-samsung
[PATCH 4/7] ARM: SAMSUNG: move hr timer for common s5p into plat-samsung
[PATCH 5/7] ARM: SAMSUNG: move platform device for s5p uart into plat-samsung
[PATCH 6/7] ARM: SAMSUNG: move setup code for s5p mfc and mipiphy into plat-samsung
[PATCH 7/7] ARM: SAMSUNG: move options for common s5p into plat-samsung/Kconfig

arch/arm/plat-s5p/Kconfig                          |  108 -----------------
arch/arm/plat-s5p/Makefile                         |   16 ---
arch/arm/plat-samsung/Kconfig                      |  122 ++++++++++++++++++++
arch/arm/plat-samsung/Makefile                     |   13 ++
.../{plat-s5p/clock.c => plat-samsung/s5p-clock.c} |    3 +-
.../dev-mfc.c => plat-samsung/s5p-dev-mfc.c}       |    4 +-
.../dev-uart.c => plat-samsung/s5p-dev-uart.c}     |   78 +++----------
.../irq-eint.c => plat-samsung/s5p-irq-eint.c}     |    3 +-
.../s5p-irq-gpioint.c}                             |    3 +-
.../irq-pm.c => plat-samsung/s5p-irq-pm.c}         |    3 +-
.../arm/{plat-s5p/irq.c => plat-samsung/s5p-irq.c} |    3 +-
arch/arm/{plat-s5p/pm.c => plat-samsung/s5p-pm.c}  |    3 +-
.../{plat-s5p/sleep.S => plat-samsung/s5p-sleep.S} |    3 +-
arch/arm/{plat-s5p => plat-samsung}/s5p-time.c     |    3 +-
.../arm/{plat-s5p => plat-samsung}/setup-mipiphy.c |    0
15 files changed, 159 insertions(+), 206 deletions(-)
rename arch/arm/{plat-s5p/clock.c => plat-samsung/s5p-clock.c} (99%)
rename arch/arm/{plat-s5p/dev-mfc.c => plat-samsung/s5p-dev-mfc.c} (97%)
rename arch/arm/{plat-s5p/dev-uart.c => plat-samsung/s5p-dev-uart.c} (57%)
rename arch/arm/{plat-s5p/irq-eint.c => plat-samsung/s5p-irq-eint.c} (99%)
rename arch/arm/{plat-s5p/irq-gpioint.c => plat-samsung/s5p-irq-gpioint.c} (99%)
rename arch/arm/{plat-s5p/irq-pm.c => plat-samsung/s5p-irq-pm.c} (98%)
rename arch/arm/{plat-s5p/irq.c => plat-samsung/s5p-irq.c} (96%)
rename arch/arm/{plat-s5p/pm.c => plat-samsung/s5p-pm.c} (95%)
rename arch/arm/{plat-s5p/sleep.S => plat-samsung/s5p-sleep.S} (98%)
rename arch/arm/{plat-s5p => plat-samsung}/s5p-time.c (99%)
rename arch/arm/{plat-s5p => plat-samsung}/setup-mipiphy.c (100%)
