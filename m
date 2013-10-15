From: richard.zhuhongxing@gmail.com (Richard Zhu)
Date: Tue, 15 Oct 2013 10:44:53 +0800
Subject: [PATCH v4 0/1] ahci: imx: setup power saving methods
Message-ID: <1381805094-14723-1-git-send-email-Hong-Xing.Zhu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v4: ahci: imx: setup power saving methods
 - Thanks for Tejun's review and comments firstly.
 - add copyright modification note in the commit message
 - export ahci_error_handler and ahci_platform_ops
 - add more detailed comments.

v3: http://www.spinics.net/lists/linux-ide/msg46641.html
 - Thanks for Tejun's suggestions.
 override the error_handler by ahci_imx_error_handler, to do
 the complete SATA device detection, enter into PDDQ mode,
 if there is no any SATA device.

 - minor modifications:
   - The format of the copyright is changed, because that the
   original one can't pass fsl internal patch reivew without
   the character '(c)'.
   - Change the module parameters to be more readable.

V2: http://www.spinics.net/lists/linux-ide/msg46606.html
 - kernel build option is replaced by the module parameter(ahci-imx.hp) 

v1: http://www.spinics.net/lists/linux-ide/msg46389.html
 * Disable sata phy internal pll reference clock when
 sysetem enter into suspend mode, enable it after resume.
 * Enter into test power down mode when there is no sata disk
 detected on the port and 'AHCI_IMX_PHY_POWER_DOWN_MODE' is
 enabled.

This patch is based on for-next branch of
"http://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git"


[v4] ahci: imx: setup power saving methods
---
 drivers/ata/ahci.h          |    2 +
 drivers/ata/ahci_imx.c      |  101 ++++++++++++++++++++++++++++++++++++++++++-
 drivers/ata/ahci_platform.c |    3 +-
 drivers/ata/libahci.c       |    4 +-
 4 files changed, 106 insertions(+), 4 deletions(-)
