From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 27 Jan 2017 22:05:06 +0200
Subject: [PATCH 0/4] phy/mfd/soc: exynos: Header cleanup
Message-ID: <20170127200510.4444-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Suggested by Marek, continuation of cleanup of PMU register defines
in headers.

Let's keep all of them in include/linux/soc/samsung/exynos-regs-pmu.h.

This is based on:
1. Marek's recent work around pinctrl/power domains/lpass:
   https://git.linaro.org/people/marek.szyprowski/linux-srpol.git
   branch: v4.10-next-tm2-pd

2. My two previous patches for cleanup:
   https://git.kernel.org/cgit/linux/kernel/git/krzk/linux.git
   branch: for-v4.11/drivers-soc-exynos-pmu-the-joy-never-ends

Affected subsystems/drivers:
1. phy - drivers,
2. mfd - headers,
3. soc/samsung - header.

However because of dependency on Marek's patchset, I do not have a clue
how to merge it... it is not an urgent stuff, so it may wait till
dependencies get in.


Best regards,
Krzysztof



Krzysztof Kozlowski (4):
  phy: exynos4: Remove duplicated defines of PHY register defines
  phy: exynos5: Remove duplicated defines of PHY register defines
  phy: exynos-mipi-video: Use consistent method to address phy registers
  phy: exynos: Use one define for enable bit

 drivers/phy/phy-exynos-dp-video.c           |  6 +--
 drivers/phy/phy-exynos-mipi-video.c         | 71 ++++++++++++++---------------
 drivers/phy/phy-exynos5-usbdrd.c            |  6 +--
 include/linux/mfd/syscon/exynos4-pmu.h      | 21 ---------
 include/linux/mfd/syscon/exynos5-pmu.h      | 49 --------------------
 include/linux/soc/samsung/exynos-regs-pmu.h | 16 ++++++-
 6 files changed, 56 insertions(+), 113 deletions(-)
 delete mode 100644 include/linux/mfd/syscon/exynos4-pmu.h
 delete mode 100644 include/linux/mfd/syscon/exynos5-pmu.h

-- 
2.9.3
