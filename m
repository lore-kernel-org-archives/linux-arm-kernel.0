From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Nov 2014 10:19:53 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Clock Fixes for v3.18
Message-ID: <cover.1415757100.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC clock fixes for v3.18.
Or alternatively for v3.19 if you feel they are too late for v3.18.


* ARM: shmobile: r8a7740 legacy: Add missing INTCA clock for irqpin module

  This problem appears to have been introduced when the r8a7740 started
  using the irqpin driver, a change made by 0b7d7820226016205 ("ARM:
  shmobile: r8a7740: Migrate from INTC to GIC") in v3.9.
  It may well have existed in a different form before then.

  It is my understanding that the problem problem only manifests if
  uboot does not start the clock: in practice it does.

* ARM: shmobile: r8a7740 legacy: Correct IIC0 parent clock

  This problem appears to have been introduced when IIC0 support was
  added to the r8a7740 by commit 6c01ba445cecb2d8 ("ARM: mach-shmobile:
  R-Mobile A1 support.") in v3.3.

  I am not aware of any run-time effect of this problem.

* ARM: shmobile: r8a7790: Fix SD3CKCR address

  This problem was introduced when div6 clock support was added to the
  r8a7790 by 46632512c4b6ed9d5 ("ARM: shmobile: r8a7790: add div6 clocks")
  in v3.10.

  As there is no SD card slot for SDHI3 on the lager board there is no
  run-time effect of this problem on boards supported in mainline.


The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-clock-fixes-for-v3.18

for you to fetch changes up to 4f37828d4d69a46830e0525a065da9847fc7a819:

  ARM: shmobile: r8a7740 legacy: Correct IIC0 parent clock (2014-11-10 09:54:12 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Clock Fixes for v3.18

* Correct IIC0 parent clock for r8a7740
* Add missing INTCA clock for irqpin module for r8a7740
* Correct SD3CKCR address on r8a7790

----------------------------------------------------------------
Geert Uytterhoeven (2):
      ARM: shmobile: r8a7740 legacy: Add missing INTCA clock for irqpin module
      ARM: shmobile: r8a7740 legacy: Correct IIC0 parent clock

Shinobu Uehara (1):
      ARM: shmobile: r8a7790: Fix SD3CKCR address

 arch/arm/mach-shmobile/clock-r8a7740.c | 9 +++++++--
 arch/arm/mach-shmobile/clock-r8a7790.c | 2 +-
 2 files changed, 8 insertions(+), 3 deletions(-)
