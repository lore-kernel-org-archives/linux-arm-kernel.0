From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 27 Mar 2018 16:29:49 +0800
Subject: [GIT PULL] Freescale arm64 device tree fixups for 4.17
Message-ID: <20180327082948.GG8857@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is a fix-up for "[GIT PULL 5/6] Freescale arm64 device tree updates
for 4.17" [1].  After the pull-request gets merged, we're pointed out by
Rob that the "fix" to IFC memory controller DTC warnings is wrong.
Let's start over again by reverting the patches first.  Sorry about the
reverting.

Shawn

[1] https://www.spinics.net/lists/arm-kernel/msg641049.html


The following changes since commit 4e017f1419397473cf3db6e9fa020013998b1aa4:

  dt-bindings: ifc: Fix the unit address format in the examples (2018-03-12 15:38:49 +0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt64-4.17-2

for you to fetch changes up to ee9c64307b6203151a20ec33e6f51ae1cac1bb6e:

  Revert "dt-bindings: ifc: Fix the unit address format in the examples" (2018-03-27 16:00:07 +0800)

----------------------------------------------------------------
Freescale arm64 device tree fixups for 4.17:
 - It reverts a couple of patches that "fix" DTC warnings on IFC memory
   controller in a wrong way.  We will start over agagin to address the
   DTC warnings later.

----------------------------------------------------------------
Fabio Estevam (2):
      Revert "arm64: dts: fsl: fix ifc simple-bus unit address format warnings"
      Revert "dt-bindings: ifc: Fix the unit address format in the examples"

 Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt | 6 +++---
 arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts                | 6 +++---
 arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts                | 6 +++---
 arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts                | 6 +++---
 arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts                | 4 ++--
 arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts                | 6 +++---
 arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts                | 4 ++--
 arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi               | 6 +++---
 8 files changed, 22 insertions(+), 22 deletions(-)
