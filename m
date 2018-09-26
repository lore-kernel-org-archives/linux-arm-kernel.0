From: monstr@monstr.eu (Michal Simek)
Date: Wed, 26 Sep 2018 09:14:16 +0200
Subject: [GIT PULL] arm64: zynqmp: Xilinx SoC changes for v4.20 v2
Message-ID: <e6a23ed7-0573-24a3-c13d-c188fb10f131@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Based on discussion with Olof I am sending this pull request
You can find out more information about content in a tag below.

Thanks,
Michal


The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

  https://github.com/Xilinx/linux-xlnx.git tags/zynqmp-soc-for-v4.20-v2

for you to fetch changes up to e60f02ddb4d2e29b0eb30dbe55475822c4bf3818:

  firmware: xilinx: Add debugfs for query data API (2018-09-26 08:47:37
+0200)

----------------------------------------------------------------
arm64: zynqmp: SoC changes for v4.20

- Adding firmware API for SoC with debugfs interface
  Firmware driver communicates to Platform Management Unit (PMU) by using
  SMC instructions routed to Arm Trusted Firmware (ATF). Initial version
  adds support for base firmware driver with query and clock APIs.

  EEMI spec is available here:

https://www.xilinx.com/support/documentation/user_guides/ug1200-eemi-api.pdf

----------------------------------------------------------------
Rajan Vaja (6):
      dt-bindings: firmware: Add bindings for ZynqMP firmware
      firmware: xilinx: Add Zynqmp firmware driver
      firmware: xilinx: Add query data API
      firmware: xilinx: Add clock APIs
      firmware: xilinx: Add debugfs interface
      firmware: xilinx: Add debugfs for query data API

 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt |  29 ++++++++
 arch/arm64/Kconfig.platforms
   |   1 +
 drivers/firmware/Kconfig
   |   1 +
 drivers/firmware/Makefile
   |   1 +
 drivers/firmware/xilinx/Kconfig
   |  23 ++++++
 drivers/firmware/xilinx/Makefile
   |   5 ++
 drivers/firmware/xilinx/zynqmp-debug.c
   | 250 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/firmware/xilinx/zynqmp-debug.h
   |  24 ++++++
 drivers/firmware/xilinx/zynqmp.c
   | 523
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h
   | 113 ++++++++++++++++++++++++++++
 10 files changed, 970 insertions(+)
 create mode 100644
Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
 create mode 100644 drivers/firmware/xilinx/Kconfig
 create mode 100644 drivers/firmware/xilinx/Makefile
 create mode 100644 drivers/firmware/xilinx/zynqmp-debug.c
 create mode 100644 drivers/firmware/xilinx/zynqmp-debug.h
 create mode 100644 drivers/firmware/xilinx/zynqmp.c
 create mode 100644 include/linux/firmware/xlnx-zynqmp.h


-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180926/2095464d/attachment.sig>
