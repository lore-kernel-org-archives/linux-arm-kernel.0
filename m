From: monstr@monstr.eu (Michal Simek)
Date: Mon, 10 Mar 2014 09:14:34 +0100
Subject: [GIT PULL v2] Xilinx Zynq changes for v3.15
In-Reply-To: <53061EBA.1080002@monstr.eu>
References: <53061EBA.1080002@monstr.eu>
Message-ID: <531D746A.4020903@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

please pull these changes to your arm-soc tree. This branch is based
on zynq/dt branch from the second pull request.
I have kept OCM patch in this branch because it depends on slcr changes
done here. If you want to send another pull request just for this OCM
patch based on this branch, please let me know.

Changes in v2: Fix incorrect git repo url

Thanks,
Michal

The following changes since commit 3795e91d2abb25164dda5687ca680a7ab940c447:

  arm: dt: zynq: Add fclk-enable property to clkc node (2014-02-03 17:00:24 +0100)

are available in the git repository at:

  git://git.xilinx.com/linux-xlnx.git tags/zynq-cleanup-for-3.15

for you to fetch changes up to e9aa3e3a5bb2d64515648537100e5cf9b863e01a:

  ARM: zynq: Add support for SOC_BUS (2014-02-20 16:08:47 +0100)

----------------------------------------------------------------
arm: Xilinx Zynq cleanup patches for v3.15

- Redesign SLCR initialization to enable
  driver developing which targets SLCR space
- Add OCM driver
- Add SOC_BUS support

----------------------------------------------------------------
Michal Simek (8):
      ARM: zynq: Split slcr in two parts
      ARM: zynq: Map I/O memory on clkc init
      ARM: zynq: Add and use zynq_slcr_read/write() helper functions
      ARM: zynq: Introduce zynq_slcr_unlock()
      ARM: zynq: Add OCM driver
      ARM: zynq: Move of_clk_init from clock driver
      ARM: zynq: Add waituart implementation
      ARM: zynq: Add support for SOC_BUS

Steffen Trumtrar (3):
      ARM: zynq: Move clock_init from slcr to common
      ARM: zynq: Hang iomapped slcr address on device_node
      ARM: zynq: Make zynq_slcr_base static

 Documentation/devicetree/bindings/arm/zynq/xlnx,zynq-ocm.txt |  17 ++++++++++++
 Documentation/devicetree/bindings/clock/zynq-7000.txt        |   4 ++-
 arch/arm/boot/dts/zynq-7000.dtsi                             |  56 ++++++++++++++++++++++---------------
 arch/arm/include/debug/zynq.S                                |   3 ++
 arch/arm/mach-zynq/Kconfig                                   |   3 ++
 arch/arm/mach-zynq/Makefile                                  |   2 +-
 arch/arm/mach-zynq/common.c                                  |  80 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 arch/arm/mach-zynq/common.h                                  |   4 ++-
 arch/arm/mach-zynq/slcr.c                                    | 138 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------
 arch/arm/mach-zynq/zynq_ocm.c                                | 243 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/zynq/clkc.c                                      |  89 ++++++++++++++++++++++++++++++++++++++++------------------
 include/linux/clk/zynq.h                                     |   2 +-
 12 files changed, 570 insertions(+), 71 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/zynq/xlnx,zynq-ocm.txt
 create mode 100644 arch/arm/mach-zynq/zynq_ocm.c



-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140310/a89094e3/attachment.sig>
