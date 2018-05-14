From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 14 May 2018 13:32:49 +0200
Subject: [GIT PULL] ARM: mediatek: soc driver updates for v4.18
Message-ID: <bd033549-4998-e376-eb92-16111ec71a07@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

Below the commits for mediatek soc drivers.
Please beware that we need the regmap-ktime-fix [1] from Mark Browns static tag.
I merged that into my branch, but I wanted to let you know, so that you don't
hit any breakage when pulling in my branch.

Regards,
Matthias

[1] https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git
tags/regmap-ktime-fix

---

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/
tags/v4.17-next-soc

for you to fetch changes up to 0afd32c6bb59e41b6692dec4473efaffffcad67b:

  Merge commit 'f15cd6d99198e9c15229aefec639a34a6e8174c6' into
v.4.17-next/soc-test (2018-05-14 12:22:03 +0200)

----------------------------------------------------------------
- use timeout helpers for scpsys and infracfg drivers
- use of_device_get_match_data in pmic wrapper and scpsys

----------------------------------------------------------------
Matthias Brugger (1):
      Merge commit 'f15cd6d99198e9c15229aefec639a34a6e8174c6' into
v.4.17-next/soc-test

Ryder Lee (1):
      soc: mediatek: use of_device_get_match_data()

Sean Wang (6):
      soc: mediatek: reuse read[l,x]_poll_timeout helpers
      regmap: include <linux/ktime.h> from include/linux/regmap.h
      soc: mediatek: reuse regmap_read_poll_timeout helpers
      soc: mediatek: introduce a CAPS flag for scp_domain_data
      soc: mediatek: add a fixed wait for SRAM stable
      soc: mediatek: remove unneeded semicolon

 drivers/soc/mediatek/mtk-infracfg.c  |  46 +++-------
 drivers/soc/mediatek/mtk-pmic-wrap.c |  13 +--
 drivers/soc/mediatek/mtk-scpsys.c    | 167 ++++++++++++++---------------------
 include/linux/regmap.h               |   1 +
 4 files changed, 83 insertions(+), 144 deletions(-)
