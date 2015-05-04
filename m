From: svarbanov@mm-sol.com (Stanimir Varbanov)
Date: Mon,  4 May 2015 15:39:09 +0300
Subject: [PATCH v2 0/5] Qualcomm PCIe and PCIe/PHY drivers
Message-ID: <1430743154-10120-1-git-send-email-svarbanov@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stanimir Varbanov <stanimir.varbanov@linaro.org>

Hi,

Here is a v2 of the patchset. The chages since v1 are:

 - take into accoint the review comments from the inital version
 - add support for pcie IP found on Snapdragon 600 (ipq/apq8064)

Version 1 of the patchset can be found at: 

https://lkml.org/lkml/2014/12/12/557

Commenst are welcome!

-------------------------------------------------------------------------------

This patchset introduces a Qualcomm PCIe root complex driver for
Snapdragon 805 (APQ8084). It also adds a PCIe PHY driver in generic
phy framework. The PCIe hardware use Designware IP core plus
Qualcomm application specific hw.

The first two patches add a PHY driver binding document and the 
PHY driver. Patches 3/5 and 4/5 add PCIe DT document and the driver.
Last 5/5 adds APQ8084 in mach-qcom as next multiplatform Qualcomm
SoC.

Stanimir Varbanov (5):
  DT: phy: qcom: Add PCIe PHY devicetree bindings
  phy: qcom: Add Qualcomm PCIe PHY
  DT: PCI: qcom: Document PCIe devicetree bindings
  PCI: qcom: Add Qualcomm PCIe controller driver
  ARM: qcom: Add Qualcomm APQ8084 SoC

 .../devicetree/bindings/pci/qcom,pcie.txt          |  231 +++++++
 .../devicetree/bindings/phy/qcom-pcie-phy.txt      |   60 ++
 MAINTAINERS                                        |    7 +
 arch/arm/mach-qcom/Kconfig                         |    7 +
 drivers/pci/host/Kconfig                           |    9 +
 drivers/pci/host/Makefile                          |    1 +
 drivers/pci/host/pcie-qcom.c                       |  677 ++++++++++++++++++++
 drivers/phy/Kconfig                                |    9 +
 drivers/phy/Makefile                               |    1 +
 drivers/phy/phy-qcom-pcie.c                        |  291 +++++++++
 10 files changed, 1293 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie.txt
 create mode 100644 Documentation/devicetree/bindings/phy/qcom-pcie-phy.txt
 create mode 100644 drivers/pci/host/pcie-qcom.c
 create mode 100644 drivers/phy/phy-qcom-pcie.c
