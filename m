From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue, 24 May 2016 13:41:00 -0400
Subject: [PATCH 0/2] ARM: dts: Fix imprecise external abort error when
 accessing Exynos MFC
Message-ID: <1464111662-15336-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series fixes an imprecise external abort error when accessing the
Exynos MFC registers due the power domain configuration requiring the
aclk333 clock to be enabled during a domain switch.

There isn't a dependency between the clock and Linux Samsung SoC trees
because the CLK_ACLK333 clock ID is already defined so the patches can
be picked indepedently by the relevant subsystem maintainers.

Best regards,
Javier


Javier Martinez Canillas (2):
  clk: exynos5420: Set ID for aclk333 gate clock
  ARM: dts: Add async-bridge clock to MFC power domain for Exynos5420

 arch/arm/boot/dts/exynos5420.dtsi    | 5 +++--
 drivers/clk/samsung/clk-exynos5420.c | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.5.5
