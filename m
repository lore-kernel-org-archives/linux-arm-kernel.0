From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 11 Mar 2017 22:00:16 +0200
Subject: [PATCH v3 0/5] phy/mfd/soc: exynos: Header cleanup
Message-ID: <20170311200021.5827-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Suggested by Marek, continuation of cleanup of PMU register defines
in headers.
Let's keep all of them in include/linux/soc/samsung/exynos-regs-pmu.h.

Everything is bisectable but should go in through one tree.
It can go through phy tree - in that case 4/5 (added in v3) needs Lee's
ack. For the rest - samsung-soc ack is given by me.
I can also take it through samsung-soc - please let me know.


Changes since v2:
=================
1. Rebase wasn't done properly (and MFD Exynos LPASS is not build by exynos
   defconfig) so Kbuild test robot reported issue. New patch 4/5.

Changes since v1:
=================
1. Rebase - dependencies should be already in.
2. Add Lee's acks.


Best regards,
Krzysztof



Krzysztof Kozlowski (5):
  phy: exynos4: Remove duplicated defines of PHY register defines
  phy: exynos5: Remove duplicated defines of PHY register defines
  phy: exynos-mipi-video: Use consistent method to address phy registers
  mfd: exynos-lpass: Use common soc/exynos-regs-pmu.h header
  phy: exynos: Use one define for enable bit

 drivers/mfd/exynos-lpass.c                  |  4 +-
 drivers/phy/phy-exynos-dp-video.c           |  6 +--
 drivers/phy/phy-exynos-mipi-video.c         | 71 ++++++++++++++---------------
 drivers/phy/phy-exynos5-usbdrd.c            |  6 +--
 include/linux/mfd/syscon/exynos4-pmu.h      | 21 ---------
 include/linux/mfd/syscon/exynos5-pmu.h      | 52 ---------------------
 include/linux/soc/samsung/exynos-regs-pmu.h | 16 ++++++-
 7 files changed, 58 insertions(+), 118 deletions(-)
 delete mode 100644 include/linux/mfd/syscon/exynos4-pmu.h
 delete mode 100644 include/linux/mfd/syscon/exynos5-pmu.h

-- 
2.9.3
