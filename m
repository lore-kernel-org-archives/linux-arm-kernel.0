From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 27 May 2015 19:39:56 +0800
Subject: [GIT PULL] ARM: imx: fixes for 4.1, 3rd round
Message-ID: <20150527113952.GF16165@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit e46b5a6470a5e2c8e1096f8f60887ac19949055b:

  ARM: dts: fix imx27 dtb build rule (2015-05-19 22:06:41 +0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.1-3

for you to fetch changes up to b17c70cd9211e9bbcd77a489f9c60f3d1bd4c392:

  ARM: imx6: gpc: don't register power domain if DT data is missing (2015-05-27 16:33:46 +0800)

----------------------------------------------------------------
The i.MX fixes for 4.1, 3rd round:

It includes a couple of fixes for i.MX6 GPC code to let the new kernel
be able to boot with old DTBs:

 - Booting v4.1-rc kernel with old DTBs will fail with a fat warning
   (require low-level debug to be seen), due to the adoption of stacked
   IRQ domain.  The first fix improves the situation by allowing kernel
   boot up with old DTBs, although suspend/resume still breaks.

 - Booting new kernel with old DTBs that do not have power-domain info
   will result in a hang.  The second patch fixes the hang by skipping
   the kernel power-domain registration if DTB has no power-domain info.

----------------------------------------------------------------
Lucas Stach (2):
      ARM: imx6: allow booting with old DT
      ARM: imx6: gpc: don't register power domain if DT data is missing

 arch/arm/mach-imx/gpc.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)
