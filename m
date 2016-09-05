From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 5 Sep 2016 10:54:45 +0800
Subject: [GIT PULL] i.MX fixes for 4.8, 2nd round
Message-ID: <20160905025445.GJ25778@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit cfee6b5874654fe4e7388bc3112d3afb76cd8b9e:

  ARM: imx6ul: populates platform device at .init_machine (2016-08-17 22:43:05 +0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.8-2

for you to fetch changes up to f065e9e4addd75c21bb976bb2558648bf4f61de6:

  ARM: dts: imx6qdl: Fix SPDIF regression (2016-09-05 10:30:58 +0800)

----------------------------------------------------------------
i.MX fixes for 4.8, 2nd round:
 - Fix misspelled "ti,x-plate-ohms" property name of touchscreen
   controller for imx7d-sdb DTS.
 - Add missing BM_CLPCR_BYPASS_PMIC_READY setting for i.MX6SX to get
   suspend/resume work properly.
 - Fix SPDIF regression on imx6qdl which caused by a clock update on
   spdif device node.

----------------------------------------------------------------
Anson Huang (1):
      ARM: imx6: add missing BM_CLPCR_BYPASS_PMIC_READY setting for imx6sx

Fabio Estevam (1):
      ARM: dts: imx6qdl: Fix SPDIF regression

Vladimir Zapolskiy (1):
      ARM: dts: imx7d-sdb: fix ti,x-plate-ohms property name

 arch/arm/boot/dts/imx6qdl.dtsi  | 2 +-
 arch/arm/boot/dts/imx7d-sdb.dts | 2 +-
 arch/arm/mach-imx/pm-imx6.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
