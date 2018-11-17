From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Sat, 17 Nov 2018 10:12:22 -0800
Subject: [PATCH 0/3] PCIE support for i.MX8MQ
Message-ID: <20181117181225.10737-1-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Everyone:

This series contains changes I made in order to enable support of PCIE
IP block on i.MX8MQ SoCs (full tree can be found at [github-v0]). This series
is _very_ preliminary and by no means is ready for inclusion (it also
has some unmet dependencies).  However is should be in OK enough shape
to get some early feedback on, which is the intent of this submission.

Specifically, I'd like to get some feedback on whether newly
introduced "fsl,iomux-gpr1x" and "fsl,gpr12-device-type" DT
properties, added to handle differences between PCIE0 and PCIE1, is a
good (acceptable) solution for the problem.

All other feedback is appreciated as well!

Thank you,
Andrey Smirnov

[github-v0] https://github.com/ndreys/linux/commits/imx8mq-pcie-v0

Andrey Smirnov (3):
  PCI: imx: No-op imx6_setup_phy_mpll() on i.MX7D
  PCI: imx: No-op imx6_pcie_reset_phy() on i.MX7D
  PCI: imx: Add support for i.MX8MQ

 drivers/pci/controller/dwc/Kconfig    |   2 +-
 drivers/pci/controller/dwc/pci-imx6.c | 119 +++++++++++++++++++++++++-
 2 files changed, 117 insertions(+), 4 deletions(-)

-- 
2.19.1
