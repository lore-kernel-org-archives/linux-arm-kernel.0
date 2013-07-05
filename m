From: richard.zhuhongxing@gmail.com (Richard Zhu)
Date: Fri,  5 Jul 2013 17:52:19 +0800
Subject: [PATCH v3 0/3] ahci: enable ahci sata support on imx6q
Message-ID: <1373017942-12583-1-git-send-email-Hong-Xing.Zhu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v3: add imx6q specific ahci sata support
  - Keep arch/arm and ahci_platform driver clean.
  - Add the sata_imx standalone driver contained all the
  specific setup
  - Add the release function, support the loadable module
  driver.
  - Tested on imx6q sd board.

v2: http://www.spinics.net/lists/linux-ide/msg45666.html 
 - Setup standalone imx ahci sata driver, because of
 the misalignments of the bits definition of the HBA register.
 - Replace the node by the label in the board dts.
 - 

v1: http://www.spinics.net/lists/linux-ide/msg45581.html
 - add imx6q specific ahci sata support to arch/arm/mach-imx/mach-imx6q.c

These patches is based on imx/dt branch of
"http://git.linaro.org/git-ro/people/shawnguo/linux-2.6.git"

[v3 1/3] ARM: dtsi: enable ahci sata on imx6q platforms
[v3 2/3] ARM: imx6q: update the sata bits definitions of gpr13
[v3 3/3] sata: imx: add ahci sata support on imx platforms

arch/arm/boot/dts/imx6q-sabreauto.dts       |    4 +
arch/arm/boot/dts/imx6q-sabrelite.dts       |    4 +
arch/arm/boot/dts/imx6q-sabresd.dts         |    4 +
arch/arm/boot/dts/imx6q.dtsi                |    9 +
drivers/ata/Kconfig                         |    9 +
drivers/ata/Makefile                        |    1 +
drivers/ata/sata_imx.c                      |  221 +++++++++++++++++++++++++++
include/linux/mfd/syscon/imx6q-iomuxc-gpr.h |  121 ++++++++++-----
8 files changed, 336 insertions(+), 37 deletions(-)
