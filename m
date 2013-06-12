From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Wed, 12 Jun 2013 09:41:05 -0700
Subject: [PATCH v2 0/3] Zynq: Support more boards
Message-ID: <1371055268-32337-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for the zc702 and zed Zynq platforms. The series
depends on armsoc/zynq/clk.
The third patch is a little tricky in terms of the compatibility strings used
since the Zed board is not a Xilinx product. I looked at the Digilent vendor
tree and they use 'xlnx,zynq-zed', so I decided to do the same here. But this
might be a subject for discussion.
https://github.com/Digilent/linux-digilent/blob/master/arch/arm/boot/dts/digilent-zed.dts#L40

	S?ren

v2:
 - adding patch to remove board specific compat strings from the BSP
 - adding patch adding Zed support

Soren Brinkmann (3):
  arm: zynq: Remove board specific compatibility string
  arm: dt: zynq: Add support for the zc706 platform
  arm: dt: zynq: Add support for the zed platform

 arch/arm/boot/dts/Makefile       |  4 +++-
 arch/arm/boot/dts/zynq-zc706.dts | 31 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/zynq-zed.dts   | 31 +++++++++++++++++++++++++++++++
 arch/arm/mach-zynq/common.c      |  1 -
 4 files changed, 65 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/zynq-zc706.dts
 create mode 100644 arch/arm/boot/dts/zynq-zed.dts

-- 
1.8.3
