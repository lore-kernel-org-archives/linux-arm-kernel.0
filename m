From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 19 Jan 2018 13:55:39 +0100
Subject: [PATCH 0/7] arm64: zynqmp: Add support for existing Xilinx ZynqMP
 based boards
Message-ID: <cover.1516366474.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patchset is adding all current existing Xilinx ZynqMP boards.
zcu* boards are customer boards. zc1* are mainly Xilinx internal boards
but some of them have been shared with customers. zc1751 is unique in
this set because it is based board with FMC card for silicon/hard IP
validation.
All boards are using the same default clock configuration till clock
driver is merged to mainline. Some boards also contain other components
which are not described because mainline driver haven't been merged yet.
For example nand, qspi, pinctrl and phy.
Please let me know if you see any issue with these boards.

Thanks,
Michal


Michal Simek (7):
  arm64: zynqmp: Add support for Xilinx zcu100-revC
  arm64: zynqmp: Add support for Xilinx zcu102
  arm64: zynqmp: Add support for Xilinx zcu104-revA
  arm64: zynqmp: Add support for Xilinx zcu106-revA
  arm64: zynqmp: Add support for Xilinx zcu111-revA
  arm64: zynqmp: Add support for Xilinx zc12XX boards
  arm64: zynqmp: Add support for Xilinx zc1751

 arch/arm64/boot/dts/xilinx/Makefile                |  15 +
 arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi         | 213 ++++++++
 arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts  |  54 ++
 arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts  |  42 ++
 arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts  |  42 ++
 .../boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts    | 133 +++++
 .../boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts    | 170 +++++++
 .../boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts    | 153 ++++++
 .../boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts    | 181 +++++++
 .../boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts    | 126 +++++
 arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts  | 298 +++++++++++
 .../arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts |  36 ++
 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts  | 556 +++++++++++++++++++++
 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts  |  42 ++
 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts  | 197 ++++++++
 arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts  | 530 ++++++++++++++++++++
 arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts  | 446 +++++++++++++++++
 17 files changed, 3234 insertions(+)
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts

-- 
1.9.1
