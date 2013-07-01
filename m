From: richard.zhuhongxing@gmail.com (Richard Zhu)
Date: Mon,  1 Jul 2013 18:02:51 +0800
Subject: [PATCH v2 0/4] ahci: enable ahci sata support on imx6q
Message-ID: <1372672975-2997-1-git-send-email-r65037@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v2: add imx6q specific ahci sata support
 - Setup standalone imx ahci sata driver, because of
 the misalignments of the bits definition of the HBA register.
 - Replace the node by the label in the board dts.
 - 

v1: http://www.spinics.net/lists/linux-ide/msg45581.html
 - add imx6q specific ahci sata support to arch/arm/mach-imx/mach-imx6q.c

These patches is based on imx/dt branch of
"http://git.linaro.org/git-ro/people/shawnguo/linux-2.6.git"



[v2 1/4] ARM: dtsi: enable ahci sata on imx6q platforms
[v2 2/4] imx: ahci: enable ahci sata on imx6q platforms
[v2 3/4] ARM: imx6q: update the sata bits definitions of gpr13
[v2 4/4] sata: imx: add ahci sata support on imx platforms

.../devicetree/bindings/ata/ahci-platform.txt      |    2 +-
arch/arm/mach-imx/mach-imx6q.c                     |   85 +++++-
drivers/ata/Kconfig                                |    8 +
drivers/ata/Makefile                               |    1 +
drivers/ata/sata_imx.c                             |  349 ++++++++++++++++++++
include/linux/mfd/syscon/imx6q-iomuxc-gpr.h        |  121 +++++--
6 files changed, 527 insertions(+), 39 deletions(-)
