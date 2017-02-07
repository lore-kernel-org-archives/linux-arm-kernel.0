From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Tue,  7 Feb 2017 07:50:24 -0800
Subject: [PATCH v4 0/3] i.MX7 PCI support
Message-ID: <20170207155027.7734-1-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, everyone:

This is a fourth iteration of the code that adds PCI-subsystem bits
necessary for enabling PCI support on i.MX7.

Changes since v3 (can be found at [version3]):
	- Move all of the reset_control_assert's into imx6_pcie_assert_core_reset
	- Documented required reset and power domain DT bindings

Changes since v2 (can be found at [version2]):

	- Collected Reviewed-by for patch #2 from Lucas
	- Reset logic implementation moved out into a reset controller
          driver (see [reset1])
	- Removed unused leftover code

Changes since v1 (can be found at [version1]):

	- All GPC related code moved into a separate driver (see [gpc1])
	- Removed GPIO probe deferral logging
	- Fixed section mismatch warning
	- Minor reformatting of fsl,imx6q-pcie.txt(as per Rob
          Herring's request)

[version3] https://lkml.org/lkml/2017/2/6/565
[version2] https://lkml.org/lkml/2017/2/1/510
[version1] https://lkml.org/lkml/2017/1/19/488
[gpc1] https://lkml.org/lkml/2017/2/6/551
[reset1] https://lkml.org/lkml/2017/2/6/554

Andrey Smirnov (3):
  PCI: imx6: Fix a typo in error message
  PCI: imx6: Allow probe deferal by reset GPIO
  PCI: imx6: Add code to support i.MX7D

 .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |  13 +-
 drivers/pci/host/pci-imx6.c                        | 131 ++++++++++++++++-----
 include/linux/mfd/syscon/imx7-iomuxc-gpr.h         |   4 +
 3 files changed, 118 insertions(+), 30 deletions(-)

-- 
2.9.3
