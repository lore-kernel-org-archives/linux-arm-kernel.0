From: josh.cartwright@ni.com (Josh Cartwright)
Date: Mon, 22 Oct 2012 16:10:40 -0500
Subject: [PATCH v2 0/4] zynq subarch cleanups
Message-ID: <20121022211040.GA31538@beefymiracle.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey all-

Things have been relatively quiet on the Zynq front lately.  This
patchset does a bit of cleanup of the Zynq subarchitecture.  It was the
necessary set of things I had to do to get a zynq target booting with
the upstream qemu model.  It removes some unused clock infrastructure,
adds DT support for the GIC, and moves around peripheral mappings.

On the CLKDEV_LOOKUP removal: the plan is to rework the out-of-tree
Xilinx generic clk support into something suitable for merging.  What's
in tree now just isn't used at all, and can be removed.

Changes since v1:
  - Make sure arm at kernel.org was included
  - Rebased on arm-soc/for-next
  - Added a cover letter
  - Elaborated a bit on why I removed CLKDEV_LOOKUP

---
Josh Cartwright (4):
  ARM: annotate VMALLOC_END definition with _AC
  zynq: move static peripheral mappings
  zynq: use GIC device tree bindings
  zynq: remove use of CLKDEV_LOOKUP

 arch/arm/Kconfig                           |  1 -
 arch/arm/boot/dts/zynq-ep107.dts           |  8 ++++---
 arch/arm/include/asm/pgtable.h             |  2 +-
 arch/arm/mach-zynq/common.c                | 16 ++++++++-----
 arch/arm/mach-zynq/include/mach/clkdev.h   | 32 --------------------------
 arch/arm/mach-zynq/include/mach/zynq_soc.h | 36 ++++++++++++++++--------------
 6 files changed, 35 insertions(+), 60 deletions(-)
 delete mode 100644 arch/arm/mach-zynq/include/mach/clkdev.h

-- 
1.8.0
