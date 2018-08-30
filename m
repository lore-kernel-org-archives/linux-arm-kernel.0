From: hanjie.lin@amlogic.com (Hanjie Lin)
Date: Thu, 30 Aug 2018 16:13:47 +0800
Subject: [PATCH v3 0/2] add the Amlogic Meson PCIe controller driver
Message-ID: <1535616829-167936-1-git-send-email-hanjie.lin@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Amlogic Meson PCIe host controller is based on the Synopsys DesignWare
PCI core. This patchset add the driver and dt-bindings of the controller.

Till patch v2, we have a dedicated phy driver which only process reset job.
It's too overkill so we integrate phy driver into the controller.

Changes since v2: [1]
 - abandon phy driver, move reset to the controller
 - use devm_add_action_or_reset() to use clock res
 - format correcting

Changes since v1: [0]
 - use gpio lib instead open code 
 - move 'apb' and 'port' reset from phy driver
 - format correcting

[0] :  https://lkml.kernel.org/r/1534227522-186798-1-git-send-email-hanjie.lin at amlogic.com
[1] :  https://lkml.kernel.org/r/1535096165-45827-1-git-send-email-hanjie.lin at amlogic.com 

Yue Wang (2):
  dt-bindings: PCI: meson: add DT bindings for Amlogic Meson PCIe
    controller
  PCI: meson: add the Amlogic Meson PCIe controller driver

 .../devicetree/bindings/pci/amlogic,meson-pcie.txt |  70 +++
 drivers/pci/controller/dwc/Kconfig                 |  12 +
 drivers/pci/controller/dwc/Makefile                |   1 +
 drivers/pci/controller/dwc/pci-meson.c             | 617 +++++++++++++++++++++
 4 files changed, 700 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
 create mode 100644 drivers/pci/controller/dwc/pci-meson.c

-- 
2.7.4
