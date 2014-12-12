From: svarbanov@mm-sol.com (Stanimir Varbanov)
Date: Fri, 12 Dec 2014 19:13:56 +0200
Subject: [PATCH 0/5] Qualcomm PCIe and PCIe/PHY drivers
Message-ID: <1418404441-5518-1-git-send-email-svarbanov@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset introduces a Qualcomm PCIe root complex driver for
Snapdragon 805 (APQ8084). It also adds a PCIe PHY driver in generic
phy framework. The PCIe hardware use Designware IP core plus
Qualcomm application specific hw.

The first two patches add a PHY driver binding document and the 
PHY driver. Patches 3/5 and 4/5 add PCIe DT document and the driver.
Last 5/5 adds APQ8084 in mach-qcom as next multiplatform Qualcomm
SoC.

Comments are welcome!

regards,
Stan

Stanimir Varbanov (5):
  DT: phy: qcom: Add PCIe PHY devicetree bindings
  phy: qcom: Add Qualcomm PCIe PHY
  DT: PCI: qcom: Document PCIe devicetree bindings
  PCI: qcom: Add Qualcomm PCIe controller driver
  ARM: qcom: Add Qualcomm APQ8084 SoC

 .../devicetree/bindings/pci/qcom,pcie.txt          |  159 ++++++++
 .../devicetree/bindings/phy/qcom-pcie-phy.txt      |   62 +++
 arch/arm/mach-qcom/Kconfig                         |    7 +
 drivers/pci/host/Kconfig                           |    9 +
 drivers/pci/host/Makefile                          |    1 +
 drivers/pci/host/pcie-qcom.c                       |  415 ++++++++++++++++++++
 drivers/phy/Kconfig                                |    7 +
 drivers/phy/Makefile                               |    1 +
 drivers/phy/phy-qcom-pcie.c                        |  311 +++++++++++++++
 9 files changed, 972 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie.txt
 create mode 100644 Documentation/devicetree/bindings/phy/qcom-pcie-phy.txt
 create mode 100644 drivers/pci/host/pcie-qcom.c
 create mode 100644 drivers/phy/phy-qcom-pcie.c
