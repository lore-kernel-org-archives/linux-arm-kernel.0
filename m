From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 3 Jan 2017 16:26:58 +0800
Subject: [GIT PULL] i.MX fixes for 4.10
Message-ID: <20170103082657.GX20956@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 0c744ea4f77d72b3dcebb7a8f2684633ec79be88:

  Linux 4.10-rc2 (2017-01-01 14:31:53 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.10

for you to fetch changes up to 116dad7d4339d0965169df8a864fc829f684794d:

  ARM: dts: imx6: Disable "weim" node in the dtsi files (2017-01-03 10:59:07 +0800)

----------------------------------------------------------------
i.MX fixes for 4.10:
 - A format fix for vf610-zii-dev-rev-b.dts, which has a very odd line
   due to misses a newline.
 - A fix to imx-weim bus error seen on board which doesn't actually use
   the bus.
 - A fix for imx6qdl-nitrogen6x board which has conflicting usage of
   pad NANDF_CS2.
 - A cleanup on i.MX1 machine to remove .map_io callback, which also
   fixes a compiling error for NOMMU build.
 - Fix AVIC base address in i.MX31 device tree source.  The problem was
   shadowed by the AVIC driver, which takes the correct base address
   from a SoC specific header file.

----------------------------------------------------------------
Andreas F?rber (1):
      ARM: dts: vf610-zii-dev-rev-b: Add missing newline

Fabio Estevam (1):
      ARM: dts: imx6: Disable "weim" node in the dtsi files

Gary Bisson (1):
      ARM: dts: imx6qdl-nitrogen6x: remove duplicate iomux entry

Vladimir Murzin (1):
      ARM: i.MX: remove map_io callback

Vladimir Zapolskiy (1):
      ARM: dts: imx31: fix AVIC base address

 arch/arm/boot/dts/imx31.dtsi              | 4 ++--
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi | 1 -
 arch/arm/boot/dts/imx6qdl.dtsi            | 1 +
 arch/arm/boot/dts/imx6sl.dtsi             | 1 +
 arch/arm/boot/dts/imx6sx.dtsi             | 1 +
 arch/arm/boot/dts/vf610-zii-dev-rev-b.dts | 3 ++-
 arch/arm/mach-imx/mach-imx1.c             | 1 -
 7 files changed, 7 insertions(+), 5 deletions(-)
