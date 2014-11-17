From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 17 Nov 2014 11:45:16 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Fixes for v3.18
Message-ID: <cover.1416192055.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC fixes for v3.18.
Or alternatively for v3.19 if you feel they are too late for v3.18.


* ARM: shmobile: kzm9g legacy: Set i2c clks_per_count

  This problem appears to have been introduced when i2c shmobile support was
  added to the sh73a0 by b028f94b76319e1b8 ("ARM: mach-shmobile: sh73a0
  i2c_shmobile support.") in v2.6.37.

  Without this fix i2c may not operate correctly on the sh73a0/kzm9g.


The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-fixes-for-v3.18

for you to fetch changes up to b207422bb92f17f4f892a9b8737d44b37fece25b:

  ARM: shmobile: kzm9g legacy: Set i2c clks_per_count to 2 (2014-11-12 10:38:30 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Fixes for v3.18

* Set i2c clks_per_count to 2 on kzm9g

----------------------------------------------------------------
Geert Uytterhoeven (1):
      ARM: shmobile: kzm9g legacy: Set i2c clks_per_count to 2

 arch/arm/mach-shmobile/setup-sh73a0.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
