From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 12 Oct 2018 17:31:17 +0200
Subject: [GIT PULL] ARM: SoC fixes for 4.19
Message-ID: <CAK8P3a0V3ddscW3x94rU0Yfh3HuTWhuhTsaKhKVy85+8ygf3Lg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 17b57b1883c1285f3d0dc2266e8f79286a7bef38:

  Linux 4.19-rc6 (2018-09-30 07:15:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
tags/armsoc-fixes-4.19

for you to fetch changes up to 3f4258bbe0363b3d5330b93de0e86b7796ff1a74:

  Merge tag 'soc-fsl-fix-v4.19-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux into fixes
(2018-10-04 18:01:20 +0200)

----------------------------------------------------------------
ARM: SoC fixes for 4.19

Two last minute bugfixes, both for NXP platforms:

* The Layerscape 'qbman' infrastructure suffers from probe ordering
  bugs in some configurations, a two-patch series adds a hotfix for
  this. 4.20 will have a longer set of patches to rework it.

* The old imx53-qsb board regressed in 4.19 after the addition
  of cpufreq support, adding a set of explicit operating points
  fixes this.

----------------------------------------------------------------
Arnd Bergmann (2):
      Merge tag 'imx-fixes-4.19-2' of
git://git.kernel.org/.../shawnguo/linux into fixes
      Merge tag 'soc-fsl-fix-v4.19-2' of
git://git.kernel.org/.../leo/linux into fixes

Laurentiu Tudor (2):
      soc: fsl: qbman: add APIs to retrieve the probing status
      soc: fsl: qman_portals: defer probe after qman's probe

Sascha Hauer (1):
      ARM: dts: imx53-qsb: disable 1.2GHz OPP

 arch/arm/boot/dts/imx53-qsb-common.dtsi | 11 +++++++++++
 drivers/soc/fsl/qbman/bman_ccsr.c       | 11 +++++++++++
 drivers/soc/fsl/qbman/qman_ccsr.c       | 11 +++++++++++
 drivers/soc/fsl/qbman/qman_portal.c     |  8 ++++++++
 include/soc/fsl/bman.h                  |  8 ++++++++
 include/soc/fsl/qman.h                  |  8 ++++++++
 6 files changed, 57 insertions(+)
