From: ludovic.Barre@st.com (Ludovic Barre)
Date: Wed, 20 Jun 2018 09:53:55 +0200
Subject: [PATCH V2 0/3] add iwdg2 support for stm32mp157c
Message-ID: <1529481238-15277-1-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch series updates stm32_iwdg driver to manage config
by compatible. stm32mp1 config requires a pclk clock.

Ludovic Barre (3):
  watchdog: stm32: add pclk feature for stm32mp1
  ARM: dts: stm32: add iwdg2 support for stm32mp157c
  ARM: dts: stm32: add iwdg2 support for stm32mp157c-ed1

 .../devicetree/bindings/watchdog/st,stm32-iwdg.txt |  21 +++-
 arch/arm/boot/dts/stm32mp157c-ed1.dts              |   5 +
 arch/arm/boot/dts/stm32mp157c.dtsi                 |   8 ++
 drivers/watchdog/stm32_iwdg.c                      | 132 ++++++++++++++-------
 4 files changed, 117 insertions(+), 49 deletions(-)

-- 
2.7.4
