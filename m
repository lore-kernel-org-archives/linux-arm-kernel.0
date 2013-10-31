From: tushar.behera@linaro.org (Tushar Behera)
Date: Thu, 31 Oct 2013 12:18:40 +0530
Subject: [PATCH 0/4] Add support for clocks in S5M8767
Message-ID: <1383202124-1775-1-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

S5M8767 chip has 3 crystal oscillators which are operated in the same
as the crystal oscillators in S2MPS11. Extend s2mps11-clk driver to
support clocks in S5M8767.

The patches are based on next-20131030.

Tushar Behera (4):
  clk: clk-s2mps11: Refactor for including support for other MFD clocks
  clk: clk-s2mps11: Add support for clocks in S5M8767 MFD
  mfd: sec-core: Add cells for S5M8767-clocks
  ARM: dts: Add S5M8767 clock nodes on Arndale board

 arch/arm/boot/dts/exynos5250-arndale.dts |    7 +++++++
 drivers/clk/Kconfig                      |    6 ++++--
 drivers/clk/clk-s2mps11.c                |   25 +++++++++++++++++++++----
 drivers/mfd/sec-core.c                   |    4 +++-
 4 files changed, 35 insertions(+), 7 deletions(-)

-- 
1.7.9.5
