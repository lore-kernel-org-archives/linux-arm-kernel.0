From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Wed, 22 Oct 2014 09:14:19 +0200
Subject: [PATCH v4 0/8] phy: miphy28lp: Introduce support for MiPHY28lp
Message-ID: <1413962067-25557-1-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes in v4:
 - use a generic phy header file for dt binding 
 - cosmetic correction
 - add comments

Changes in v3:
 - split into separate smaller functions and can be resued 
   for sata / pcie and usb
 - uses macros for registers and values
 - cosmetic correction

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
  phy: miphy28lp: Add PHY header file for DT x Driver defines
  phy: miphy28lp: Provide support for the MiPHY28lp Generic PHY
  ARM: DT: STi: STiH407: Add DT node for MiPHY28lp
  phy: miphy28lp: Add SSC support for SATA
  phy: miphy28lp: Add SSC support for PCIE
  phy: miphy28lp: Tune tx impedance across Soc cuts
  ARM: multi_v7_defconfig: Enable MiPHY28lp - ST's Generic (SATA, PCIe &
    USB3) PHY

 .../devicetree/bindings/phy/phy-miphy28lp.txt      |  128 ++
 arch/arm/boot/dts/stih407-b2120.dts                |   11 +
 arch/arm/boot/dts/stih407.dtsi                     |   65 +
 arch/arm/configs/multi_v7_defconfig                |    1 +
 drivers/phy/Kconfig                                |    8 +
 drivers/phy/Makefile                               |    1 +
 drivers/phy/phy-miphy28lp.c                        | 1280 ++++++++++++++++++++
 include/dt-bindings/phy/phy.h                      |   17 +
 8 files changed, 1511 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-miphy28lp.txt
 create mode 100644 drivers/phy/phy-miphy28lp.c
 create mode 100644 include/dt-bindings/phy/phy.h

-- 
1.9.1
