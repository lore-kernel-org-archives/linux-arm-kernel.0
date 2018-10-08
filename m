From: hanjie.lin@amlogic.com (Hanjie Lin)
Date: Mon, 8 Oct 2018 19:57:11 +0800
Subject: [PATCH v4 0/2] add the Amlogic Meson PCIe controller driver
Message-ID: <1538999834-156423-1-git-send-email-hanjie.lin@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Amlogic Meson PCIe host controller is based on the Synopsys DesignWare
PCI core. This patchset add the driver and dt-bindings of the controller.

Changes since v3: [2]
 - modify subject format
 - update Kconfig
 - update MAINTAINER file
 - add comment and error handle for meson_pcie_get_mem_shared() 
 - drop useless initialization code
 - add comment for meson_size_to_payload()
 - optimize meson_pcie_establish_link() return code
 - optimize meson_pcie_enable_interrupts() redundant function
 - drop device_attch related code
 - drop dw_pcie_ops read_dbi and write_dbi function
 - add error handle for meson_add_pcie_port() when probe

Changes since v2: [1]
 - abandon phy driver, move reset to the controller
 - use devm_add_action_or_reset() to use clock res
 - format correcting

Changes since v1: [0]
 - use gpio lib instead open code
 - move 'apb' and 'port' reset from phy driver
 - format correcting

[0] : https://lkml.kernel.org/r/1534227522-186798-1-git-send-email-hanjie.lin at amlogic.com
[1] : https://lkml.kernel.org/r/1535096165-45827-1-git-send-email-hanjie.lin at amlogic.com
[2] : https://lkml.kernel.org/r/1537509820-52040-1-git-send-email-hanjie.lin at amlogic.com


Yue Wang (2):
  dt-bindings: PCI: meson: add DT bindings for Amlogic Meson PCIe
    controller
  PCI: amlogic: Add the Amlogic Meson PCIe controller driver

 .../devicetree/bindings/pci/amlogic,meson-pcie.txt |  70 +++
 MAINTAINERS                                        |   7 +
 drivers/pci/controller/dwc/Kconfig                 |  10 +
 drivers/pci/controller/dwc/Makefile                |   1 +
 drivers/pci/controller/dwc/pci-meson.c             | 593 +++++++++++++++++++++
 5 files changed, 681 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
 create mode 100644 drivers/pci/controller/dwc/pci-meson.c

-- 
2.7.4
