From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 20 Nov 2015 09:12:39 +0900
Subject: [PATCH v2 0/2] arm64: EXYNOS: Consolidate Exynos7 symbol
Message-ID: <1447978361-18010-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

We don't need ARCH_EXYNOS7 symbol because all ARMv8 platforms should
fall under generic ARCH_EXYNOS. In the same time there is no sense
in building clocks for these ARMv8 SoCs on ARMv7 builds. In future
this will also influence PMU [1] driver.

Patch 2 *depends* on patch 1. Patch 1 received acks from Samsung clock
folks so everything can go through Samsung-soc or ARM64 tree.

Best regards,
Krzysztof


[1] https://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg48090.html


Krzysztof Kozlowski (2):
  clk: samsung: Don't build ARMv8 clock drivers on ARMv7
  arm64: EXYNOS: Consolidate ARCH_EXYNOS7 symbol into ARCH_EXYNOS

 arch/arm64/Kconfig.platforms        | 11 ++---------
 arch/arm64/boot/dts/exynos/Makefile |  2 +-
 arch/arm64/configs/defconfig        |  2 +-
 drivers/clk/samsung/Kconfig         |  6 ++++++
 drivers/clk/samsung/Makefile        |  4 ++--
 5 files changed, 12 insertions(+), 13 deletions(-)

-- 
1.9.1
