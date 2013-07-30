From: tony@atomide.com (Tony Lindgren)
Date: Tue, 30 Jul 2013 06:30:52 -0700
Subject: [GIT PULL] urgent omap5 regulator updates against v3.11-rc3
Message-ID: <20130730133052.GK7656@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:

  Linux 3.11-rc1 (2013-07-14 15:18:27 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.11/fixes-omap5

for you to fetch changes up to bd3c5544a1e98a25d2d24c98779092e0f84373f7:

  ARM: dts: omap5-uevm: update optional/unused regulator configurations (2013-07-29 23:43:20 -0700)

----------------------------------------------------------------
Fixes for omap5-uevm regulators from Nishanth Menon <nm@ti.com>:

Due to wrong older revision of documentation used as reference, we
seem to have a bunch of LDOs wrongly configured on OMAP5 uEVM. This
series is based power tree on production board 750-2628-XXX platform.
Unfortunately, the wrong voltages may be detrimental to OMAP5 as they
supply hardware blocks at voltages that are out of specification.

There is a chance that without these fixes there can be hardware
damage to omap5-uevm boards with the v3.11-rc series.

----------------------------------------------------------------
Nishanth Menon (3):
      ARM: dts: omap5-uevm: document regulator signals used on the actual board
      ARM: dts: omap5-uevm: fix regulator configurations mandatory for SoC
      ARM: dts: omap5-uevm: update optional/unused regulator configurations

 arch/arm/boot/dts/omap5-uevm.dts | 78 +++++++++++++++++++++++++---------------
 1 file changed, 49 insertions(+), 29 deletions(-)
