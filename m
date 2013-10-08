From: richard.zhuhongxing@gmail.com (Richard Zhu)
Date: Tue,  8 Oct 2013 17:29:21 +0800
Subject: [PATCH v2 0/1] ahci: imx: setup power saving methods
Message-ID: <1381224562-2378-1-git-send-email-Hong-Xing.Zhu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v2: ahci: imx: setup power saving methods
 - kernel build option is replaced by the module parameter(ahci-imx.hp) 

v1: http://www.spinics.net/lists/linux-ide/msg46389.html
 * Disable sata phy internal pll reference clock when
 sysetem enter into suspend mode, enable it after resume.
 * Enter into test power down mode when there is no sata disk
 detected on the port and 'AHCI_IMX_PHY_POWER_DOWN_MODE' is
 enabled.

This patche is based on for-next branch of
"http://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git"


[v2] ahci: imx: setup power saving methods
drivers/ata/ahci_imx.c |   85 ++++++++++++++++++++++++++++++++++++++++++++++--
1 files changed, 82 insertions(+), 3 deletions(-)
