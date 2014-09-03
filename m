From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Wed,  3 Sep 2014 17:37:09 +0200
Subject: [PATCH v2 0/8] phy: miphy28lp: Introduce support for MiPHY28lp
Message-ID: <1409758637-28654-1-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes in v2:
from Kishon
 - create a common file for phy
 - cosmetic correction in phy-miphy28lp.txt file
 - change initialization of the registers
from Srinivas
 - rename and simplify a procedure
 - Add Tx impedance and SSC support for SATA and PCI

Hi Kishon,

The goal of this series is to add the support of MiPHY28lp Generic PHY.
I tried to be as close as possible to the MiPHY365x Lee Jones proposal.

Best Regards
Gabriel.

Gabriel Fernandez (8):
  phy: miphy28lp: Add Device Tree bindings for the MiPHY28lp
  phy: miphy28lp: Add MiPHY28lp header file for DT x Driver defines
  phy: miphy28lp: Provide support for the MiPHY28lp Generic PHY
  ARM: DT: STi: STiH407: Add DT node for MiPHY28lp
  ARM: multi_v7_defconfig: Enable MiPHY28lp - ST's Generic (SATA, PCIe &
    USB3) PHY
  phy: miphy28lp: Add SSC support for SATA
  phy: miphy28lp: Add SSC support for PCIE
  phy: miphy28lp: Tune tx impedance across Soc cuts

 .../devicetree/bindings/phy/phy-miphy28lp.txt      |  128 +++
 arch/arm/boot/dts/stih407-b2120.dts                |   11 +
 arch/arm/boot/dts/stih407.dtsi                     |   65 ++
 arch/arm/configs/multi_v7_defconfig                |    1 +
 drivers/phy/Kconfig                                |    8 +
 drivers/phy/Makefile                               |    1 +
 drivers/phy/phy-miphy28lp.c                        | 1076 ++++++++++++++++++++
 include/dt-bindings/phy/phy-miphy.h                |   12 +
 8 files changed, 1302 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-miphy28lp.txt
 create mode 100644 drivers/phy/phy-miphy28lp.c
 create mode 100644 include/dt-bindings/phy/phy-miphy.h

-- 
1.9.1
