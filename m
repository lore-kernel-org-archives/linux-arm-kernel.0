From: monstr@monstr.eu (Michal Simek)
Date: Tue, 9 Oct 2018 13:48:50 +0200
Subject: [GIT PULL] arm64: zynqmp: Xilinx SoC CLK changes for v4.20
Message-ID: <86e1c3a5-c507-172c-534e-5ff0070044e8@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I know it is a little bit late but please consider pulling these soc clk
changes to your tree. They are based on
https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git/log/?h=zynq/firmware
branch that's why please take this changes via arm-soc tree as was
agreed with Olof.

All patches were reviewed by appropriate maintainers.

Thanks,
Michal

The following changes since commit e60f02ddb4d2e29b0eb30dbe55475822c4bf3818:

  firmware: xilinx: Add debugfs for query data API (2018-09-26 08:47:37
+0200)

are available in the git repository at:

  https://github.com/Xilinx/linux-xlnx.git tags/zynqmp-soc-clk-for-v4.20

for you to fetch changes up to 3fde0e16d016ecb273f0fa404b5d56b947fc0576:

  drivers: clk: Add ZynqMP clock driver (2018-10-09 13:29:19 +0200)

----------------------------------------------------------------
arm64: zynqmp: SoC CLK changes for v4.20

This patchset adds CCF compliant clock driver for ZynqMP.
Clock driver queries supported clock information from firmware
and regiters pll and output clocks with CCF.

----------------------------------------------------------------
Jolly Shah (1):
      drivers: clk: Add ZynqMP clock driver

Rajan Vaja (3):
      Documentation: xilinx: Add documentation for eemi APIs
      firmware: xilinx: Add zynqmp IOCTL API for device control
      dt-bindings: clock: Add bindings for ZynqMP clock driver

 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt |  53 ++++++++++
 Documentation/xilinx/eemi.txt
   |  67 +++++++++++++
 drivers/clk/Kconfig
   |   1 +
 drivers/clk/Makefile
   |   1 +
 drivers/clk/zynqmp/Kconfig
   |  10 ++
 drivers/clk/zynqmp/Makefile
   |   4 +
 drivers/clk/zynqmp/clk-gate-zynqmp.c
   | 144 ++++++++++++++++++++++++++
 drivers/clk/zynqmp/clk-mux-zynqmp.c
   | 141 ++++++++++++++++++++++++++
 drivers/clk/zynqmp/clk-zynqmp.h
   |  68 +++++++++++++
 drivers/clk/zynqmp/clkc.c
   | 716
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/zynqmp/divider.c
   | 217 ++++++++++++++++++++++++++++++++++++++++
 drivers/clk/zynqmp/pll.c
   | 335 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/firmware/xilinx/zynqmp.c
   |  42 ++++++++
 include/dt-bindings/clock/xlnx,zynqmp-clk.h
   | 116 +++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h
   |   5 +-
 15 files changed, 1919 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/xilinx/eemi.txt
 create mode 100644 drivers/clk/zynqmp/Kconfig
 create mode 100644 drivers/clk/zynqmp/Makefile
 create mode 100644 drivers/clk/zynqmp/clk-gate-zynqmp.c
 create mode 100644 drivers/clk/zynqmp/clk-mux-zynqmp.c
 create mode 100644 drivers/clk/zynqmp/clk-zynqmp.h
 create mode 100644 drivers/clk/zynqmp/clkc.c
 create mode 100644 drivers/clk/zynqmp/divider.c
 create mode 100644 drivers/clk/zynqmp/pll.c
 create mode 100644 include/dt-bindings/clock/xlnx,zynqmp-clk.h

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181009/40867021/attachment.sig>
