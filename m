From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Mon, 24 Oct 2016 10:40:03 +0200
Subject: [PATCH v2 0/3] STM32F429: Add Ethernet fixes
Message-ID: <1477298406-22805-1-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This v2 to avoid build issue when only patch 1 (of first series) 
was build. 

This series adds several fixes for Ethernet for stm32f429 MCU.
First patch has already been reviewed some months ago when 
stm32 Ethernet glue has been pushed (I added in this series to keep
history). Fixes are:
 -Change DT to be compliant to stm32 ethernet glue binding
 -Add phy-handle to correctly use mdio subnode
 -Remove WoL support

changes since v1:
 -squash patch1 and patch2. 

Regards

Alex

Alexandre TORGUE (3):
  ARM: dts: stm32f429: Align Ethernet node with new bindings properties
  ARM: dts: stm32f429: Fix Ethernet node on Eval Board
  ARM: dts: stm32f429: remove Ethernet wake on Lan support

 arch/arm/boot/dts/stm32429i-eval.dts |  7 ++++---
 arch/arm/boot/dts/stm32f429.dtsi     | 10 +++++-----
 2 files changed, 9 insertions(+), 8 deletions(-)

-- 
1.9.1
