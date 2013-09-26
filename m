From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 26 Sep 2013 11:24:45 +0800
Subject: [PATCH v7 0/2] Add PCIe support for i.MX6q
Message-ID: <1380165887-13506-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

This is basically a resend of imx6 pcie driver patch for inclusion into
PCI tree.  Since we expect you apply the patch with your SoB, I dropped 
your ACK tag there.

I have to ask you to carry the first patch which adds some macros to be
used by pcie driver patch.  Since imx6q-iomuxc-gpr.h gets rare updates
recently, it should be less likely we will run into merge conflict on it.

Changes since v6:

* Drop arch bits from driver patch, and will handle arch bits through
  arm-soc separately.
* Use devm_clk_get() instead of clk_get().
* Drop unnecessary (val != exp_val) check in pcie_phy_poll_ack() loop.
* Rename function imx6_init() to imx6_pcie_init().

Shawn

Sean Cross (2):
  ARM: imx6q: Add PCIe bits to GPR syscon definition
  PCI: imx6: Add support for i.MX6 PCIe controller

 .../devicetree/bindings/pci/designware-pcie.txt    |    7 +-
 drivers/pci/host/Kconfig                           |    6 +
 drivers/pci/host/Makefile                          |    1 +
 drivers/pci/host/pci-imx6.c                        |  576 ++++++++++++++++++++
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h        |    8 +
 5 files changed, 597 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pci/host/pci-imx6.c

-- 
1.7.9.5
