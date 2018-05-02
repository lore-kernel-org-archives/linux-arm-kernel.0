From: christophe.roullier@st.com (Christophe Roullier)
Date: Wed, 2 May 2018 16:18:35 +0200
Subject: [PATCH V2 0/8] net: ethernet: stmmac: add support for stm32mp1
Message-ID: <1525270723-18241-1-git-send-email-christophe.roullier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patches to have Ethernet support on stm32mp1
Changelog:
Remark from Andrew Lunn
In drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
Add support of PHY_INTERFACE_MODE_RGMII_ID, PHY_INTERFACE_MODE_RGMII_RXID, 
PHY_INTERFACE_MODE_RGMII_TXID.

Remark from Rob Herring
In arch/arm/boot/dts/stm32mp157-pinctrl.dtsi:
Replace @0 with -0
In Documentation/devicetree/bindings/arm/stm32.txt
 .../devicetree/bindings/net/stm32-dwmac.txt
Update with requirement of Rob
In arch/arm/boot/dts/stm32mp157c.dtsi:
Remove compatible "st,stm32-syscfg" and use only generic "syscon"

Christophe Roullier (8):
  net: ethernet: stmmac: add adaptation for stm32mp157c.
  dt-bindings: stm32-dwmac: add support of MPU families
  ARM: dts: stm32: add ethernet pins to stm32mp157c
  ARM: dts: stm32: Add syscfg on stm32mp1
  ARM: dts: stm32: Add ethernet dwmac on stm32mp1
  net: stmmac: add dwmac-4.20a compatible
  ARM: dts: stm32: add support of ethernet on stm32mp157c-ev1
  dt-bindings: stm32: add compatible for syscon

 Documentation/devicetree/bindings/arm/stm32.txt    |   4 +
 .../devicetree/bindings/net/stm32-dwmac.txt        |  18 +-
 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi          |  46 ++++
 arch/arm/boot/dts/stm32mp157c-ev1.dts              |  20 ++
 arch/arm/boot/dts/stm32mp157c.dtsi                 |  35 +++
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c  | 270 +++++++++++++++++++--
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |   3 +-
 7 files changed, 378 insertions(+), 18 deletions(-)

-- 
1.9.1
