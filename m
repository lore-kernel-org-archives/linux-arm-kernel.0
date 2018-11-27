From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Tue, 27 Nov 2018 17:48:14 +0100
Subject: [PATCH 0/3] mfd: syscon: Add optional clock support needed on stm32
Message-ID: <1543337297-21873-1-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

STM32 syscfg registers are accessed using syscon. It needs syscfg clock
to be enabled while accessing registers.
This adds support for optional clock on syscon, and the relevant clock
in stm32mp157 device tree.

Fabrice Gasnier (3):
  dt-bindings: mfd: syscon: Add optional clock support
  mfd: syscon: Add optional clock support
  ARM: dts: stm32: Add clock on stm32mp157c syscfg

 Documentation/devicetree/bindings/mfd/syscon.txt |  1 +
 arch/arm/boot/dts/stm32mp157c.dtsi               |  1 +
 drivers/mfd/syscon.c                             | 19 +++++++++++++++++++
 3 files changed, 21 insertions(+)

-- 
1.9.1
