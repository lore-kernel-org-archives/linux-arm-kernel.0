From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 25 Jan 2016 09:50:19 +0900
Subject: [RESEND v2 0/2] arm64: EXYNOS: Consolidate Exynos7 symbol
Message-ID: <1453683021-6998-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Michael and Stephen,


Patch 2 *depends* on patch 1. I was thinking about merging this through
arm-soc tree after getting your acks.

Can you look at patch 1 here and share your comments?



Short introduction
==================
We don't need ARCH_EXYNOS7 symbol because all ARMv8 platforms should
fall under generic ARCH_EXYNOS. In the same time there is no sense
in building clocks for these ARMv8 SoCs on ARMv7 builds. In future
this will also influence PMU [1] driver.


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
