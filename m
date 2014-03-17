From: monstr@monstr.eu (Michal Simek)
Date: Mon, 17 Mar 2014 16:20:50 +0100
Subject: [GIT PULL v3] Xilinx Zynq changes for v3.15
In-Reply-To: <20140317044453.GA18210@quad.lixom.net>
References: <53061EBA.1080002@monstr.eu> <531D746A.4020903@monstr.eu>
 <20140311213331.GA6429@quad.lixom.net> <53204D22.2000703@monstr.eu>
 <20140317044453.GA18210@quad.lixom.net>
Message-ID: <532712D2.4020004@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

please pull these changes to your arm-soc tree. This branch is based
on zynq/dt branch.
Based on my discussion with Olof I have removed zynq-ocm driver
from this pull request and we will investigate different solution

Changes in v3: Remove OCM driver from pull request
Changes in v2: Fix incorrect git repo url

Thanks,
Michal


The following changes since commit 3795e91d2abb25164dda5687ca680a7ab940c447:

  arm: dt: zynq: Add fclk-enable property to clkc node (2014-02-03 17:00:24 +0100)

are available in the git repository at:

  git://git.xilinx.com/linux-xlnx.git tags/zynq-cleanup-for-3.15-v2

for you to fetch changes up to bffc3b8d2197f5e0622a6f0afb30bffeb326f942:

  ARM: zynq: Add support for SOC_BUS (2014-03-17 15:13:25 +0100)

----------------------------------------------------------------
arm: Xilinx Zynq cleanup patches for v3.15

- Redesign SLCR initialization to enable
  driver developing which targets SLCR space
- Add SOC_BUS support

----------------------------------------------------------------
Michal Simek (7):
      ARM: zynq: Split slcr in two parts
      ARM: zynq: Map I/O memory on clkc init
      ARM: zynq: Add and use zynq_slcr_read/write() helper functions
      ARM: zynq: Introduce zynq_slcr_unlock()
      ARM: zynq: Move of_clk_init from clock driver
      ARM: zynq: Add waituart implementation
      ARM: zynq: Add support for SOC_BUS

Steffen Trumtrar (3):
      ARM: zynq: Move clock_init from slcr to common
      ARM: zynq: Hang iomapped slcr address on device_node
      ARM: zynq: Make zynq_slcr_base static

 Documentation/devicetree/bindings/clock/zynq-7000.txt |   4 ++-
 arch/arm/boot/dts/zynq-7000.dtsi                      |  49 ++++++++++++++-------------
 arch/arm/include/debug/zynq.S                         |   3 ++
 arch/arm/mach-zynq/Kconfig                            |   2 ++
 arch/arm/mach-zynq/common.c                           |  80 ++++++++++++++++++++++++++++++++++++++++++--
 arch/arm/mach-zynq/common.h                           |   3 +-
 arch/arm/mach-zynq/slcr.c                             | 123 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------
 drivers/clk/zynq/clkc.c                               |  89 ++++++++++++++++++++++++++++++++++---------------
 include/linux/clk/zynq.h                              |   2 +-
 9 files changed, 285 insertions(+), 70 deletions(-)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140317/774400d2/attachment.sig>
