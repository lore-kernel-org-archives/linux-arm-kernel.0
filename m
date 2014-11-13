From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Nov 2014 10:20:04 +0900
Subject: [GIT PULL] Renesas ARM Based SoC DT Fixes for v3.18
Message-ID: <cover.1415756961.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC DT fixes for v3.18.
Or alternatively for v3.19 if you feel they are too late for v3.18.


* ARM: shmobile: r8a7740 dtsi: Correct IIC0 parent clock

  This problem was introduced when clock support was added DT for the
  r8a7740 by d9ffd583bf345e2ea ("ARM: shmobile: r8a7740: add SoC clocks to
  DTS") in v3.18-rc1.

  I am not aware of any run-time effect of this problem.

* ARM: shmobile: r8a7790: Fix SD3CKCR address to device tree

  This problem was introduced when clock support was added DT for the
  r8a7790 by 22a1f59547e1e63cd ("ARM: shmobile: r8a7790: Add clocks")
  in v3.13.

  As there is no SD card slot for SDHI3 on the lager board there is no
  run-time effect of this problem on boards supported in mainline.


The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-fixes-for-v3.18

for you to fetch changes up to b89ff7c3c2dee189489a5f45eb8d72e106179299:

  ARM: shmobile: r8a7740 dtsi: Correct IIC0 parent clock (2014-11-10 09:56:01 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC DT Fixes for v3.18

* Correct IIC0 parent clock on r8a7740
* Correct SD3CKCR address to device tree on r8a7790

----------------------------------------------------------------
Geert Uytterhoeven (1):
      ARM: shmobile: r8a7740 dtsi: Correct IIC0 parent clock

Shinobu Uehara (1):
      ARM: shmobile: r8a7790: Fix SD3CKCR address to device tree

 arch/arm/boot/dts/r8a7740.dtsi | 2 +-
 arch/arm/boot/dts/r8a7790.dtsi | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)
