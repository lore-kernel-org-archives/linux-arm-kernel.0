From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 16 May 2017 22:06:47 +0200
Subject: [PATCH 0/2] pinctrl: samsung: Split per ARMv7/v8 arch
Message-ID: <20170516200649.4730-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

There will not be a shared image between ARMv7 and ARMv8 so there is no need to
combine all of this into one driver.

Splitting the data allows to make it more granular (e.g. code related to
ARMv8 Exynos is self-contained), slightly speed up the compilation and
reduce the effective size of compiled kernel.

Diff of second patch is not nice... but it is the best I created.
Experimenting with -B and -M resulted in detection of copy/rename but end
diff was 60% bigger in lines of patch.

Tests on ARMv8 would be much appreciated.


Best regards,
Krzysztof


Krzysztof Kozlowski (2):
  pinctrl: samsung: Add include guard to local header
  pinctrl: samsung: Split Exynos drivers per ARMv7 and ARMv8

 drivers/pinctrl/samsung/Kconfig                |   10 +
 drivers/pinctrl/samsung/Makefile               |    2 +
 drivers/pinctrl/samsung/pinctrl-exynos-arm.c   |  815 +++++++++++++++++
 drivers/pinctrl/samsung/pinctrl-exynos-arm64.c |  399 ++++++++
 drivers/pinctrl/samsung/pinctrl-exynos.c       | 1163 +-----------------------
 drivers/pinctrl/samsung/pinctrl-exynos.h       |   13 +
 drivers/pinctrl/samsung/pinctrl-samsung.c      |    8 +-
 7 files changed, 1250 insertions(+), 1160 deletions(-)
 create mode 100644 drivers/pinctrl/samsung/pinctrl-exynos-arm.c
 create mode 100644 drivers/pinctrl/samsung/pinctrl-exynos-arm64.c

-- 
2.9.3
