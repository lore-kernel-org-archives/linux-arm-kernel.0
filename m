From: ludovic.Barre@st.com (Ludovic Barre)
Date: Thu, 21 Jun 2018 11:02:13 +0200
Subject: [PATCH V4 0/4] add iwdg2 support for stm32mp157c
Message-ID: <1529571737-3552-1-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch series updates stm32_iwdg driver to manage pclk
clock by compatible. stm32mp1 requires a pclk clock.

v4:
-dt-bindings: split and review

v3:
-remove stm32_iwdg_config structure, just assign the
 boolean directly to .dat

Ludovic Barre (4):
  dt-bindings: watchdog: add stm32mp1 support
  watchdog: stm32: add pclk feature for stm32mp1
  ARM: dts: stm32: add iwdg2 support for stm32mp157c
  ARM: dts: stm32: add iwdg2 support for stm32mp157c-ed1

 .../devicetree/bindings/watchdog/st,stm32-iwdg.txt |  13 ++-
 arch/arm/boot/dts/stm32mp157c-ed1.dts              |   5 +
 arch/arm/boot/dts/stm32mp157c.dtsi                 |   8 ++
 drivers/watchdog/stm32_iwdg.c                      | 116 +++++++++++++--------
 4 files changed, 97 insertions(+), 45 deletions(-)

-- 
2.7.4
