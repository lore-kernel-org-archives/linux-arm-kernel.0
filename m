From: christophe.roullier@st.com (Christophe Roullier)
Date: Wed, 23 May 2018 17:47:51 +0200
Subject: [PATCH V4 0/8] net: ethernet: stmmac: add support for stm32mp1
Message-ID: <1527090479-5263-1-git-send-email-christophe.roullier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patches to have Ethernet support on stm32mp1
Changelog:
Remark from Rob Herring
Move Documentation/devicetree/bindings/arm/stm32.txt in 
Documentation/devicetree/bindings/arm/stm32/stm32.txt and create
Documentation/devicetree/bindings/arm/stm32/stm32-syscon.txt

Replace also in arch/arm/boot/dts/stm32mp157c.dtsi, syscfg: system-config at 50020000 
with syscfg: syscon at 50020000syscfg: system-config at 50020000 

Christophe Roullier (8):
  net: ethernet: stmmac: add adaptation for stm32mp157c.
  dt-bindings: stm32-dwmac: add support of MPU families
  ARM: dts: stm32: add ethernet pins to stm32mp157c
  ARM: dts: stm32: Add syscfg on stm32mp1
  ARM: dts: stm32: Add ethernet dwmac on stm32mp1
  net: stmmac: add dwmac-4.20a compatible
  ARM: dts: stm32: add support of ethernet on stm32mp157c-ev1
  dt-bindings: stm32: add compatible for syscon

 Documentation/devicetree/bindings/arm/stm32.txt    |  10 -
 .../devicetree/bindings/arm/stm32/stm32-syscon.txt |  14 ++
 .../devicetree/bindings/arm/stm32/stm32.txt        |  10 +
 .../devicetree/bindings/net/stm32-dwmac.txt        |  18 +-
 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi          |  46 ++++
 arch/arm/boot/dts/stm32mp157c-ev1.dts              |  20 ++
 arch/arm/boot/dts/stm32mp157c.dtsi                 |  35 +++
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c  | 270 +++++++++++++++++++--
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |   3 +-
 9 files changed, 398 insertions(+), 28 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/stm32.txt
 create mode 100644 Documentation/devicetree/bindings/arm/stm32/stm32-syscon.txt
 create mode 100644 Documentation/devicetree/bindings/arm/stm32/stm32.txt

-- 
1.9.1
