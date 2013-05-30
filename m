From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Thu, 30 May 2013 15:27:40 +0200
Subject: [PATCH 0/5] Various DT fixes related to ux500 ASoC driver
Message-ID: <1369920465-13905-1-git-send-email-fabio.baltieri@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus, Lee,

these are various fixes I found while testing the ux500 ASoC driver on HREF
with device-tree.

First two patches are typos in DT files, while the others are
specifically to support ux500 ASoC driver with DT enabled.

The last patch can go in the mfd tree, while the others may safely go
through arm-soc, as there are no build dependencies or regression issues
in general.

Thanks,
Fabio


Fabio Baltieri (5):
  ARM: ux500: Fix trivial typo in v-anamic1 comment
  ARM: ux500: Correct anamic2 typo in DT files
  ARM: ux500: Add DT regulators for ab8500-codec
  ARM: ux500: Provide auxdata to ux500 ASoC driver
  mfd: ab8500-core: Add of_compatible property for ab8500-codec

 arch/arm/boot/dts/dbx5x0.dtsi     | 11 ++++++++---
 arch/arm/boot/dts/href.dtsi       |  2 +-
 arch/arm/boot/dts/hrefv60plus.dts |  2 +-
 arch/arm/boot/dts/snowball.dts    |  2 +-
 arch/arm/mach-ux500/cpu-db8500.c  |  2 ++
 drivers/mfd/ab8500-core.c         |  1 +
 drivers/regulator/ab8500.c        |  8 ++++----
 7 files changed, 18 insertions(+), 10 deletions(-)

-- 
1.8.2
