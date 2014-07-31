From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 31 Jul 2014 18:42:16 +0200
Subject: [PATCH 0/7] arm: mediatek: Add more basic features
Message-ID: <1406824943-24052-1-git-send-email-matthias.bgg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set is based on the patches merged for v3.17 in the clock [0] and arm-soc [1] repositories.

The most important patch enables the arm arch timer for mt6589. As already seen on other vendor SoCs, to enable the arch timer we have to enable a SoC timer.
This should be normally done by the bootloader. As up to now no open source bootloader exists for the mt6589, I added the functionality to the init_time function.

Other features are low-level debugging on the mt6589, the addition to the "make dtbs" and multi_v7_defconfig, as well as a small typo in the dtsi file.

[0] http://git.linaro.org/people/daniel.lezcano/linux.git/shortlog/refs/heads/clockevents/3.17
[1] https://git.kernel.org/cgit/linux/kernel/git/arm/arm-soc.git/commit/?h=next/soc&id=60c70c8c58d8cde3813e730d4e753531f292a1f0

Matthias Brugger (7):
  arm: dts: Build dtb for Mediatek board
  arm: multi_v7_defconfig: Enable Mediatek platform
  arm: dts: mt6589: Fix typo in GIC unit address
  arm: mediatek: Add earlyprintk support for mt6589
  arm: dts: mt6589-aquaris5: Add boot argument earlyprintk
  arm: mediatek: enable gpt6 on boot up to make arch timer working
  arm: dts: mt6589: Add arm arch timer node

 arch/arm/Kconfig.debug                |   10 ++++++++++
 arch/arm/boot/dts/Makefile            |    1 +
 arch/arm/boot/dts/mt6589-aquaris5.dts |    4 ++++
 arch/arm/boot/dts/mt6589.dtsi         |   14 +++++++++++---
 arch/arm/configs/multi_v7_defconfig   |    1 +
 arch/arm/mach-mediatek/mediatek.c     |   27 +++++++++++++++++++++++++++
 6 files changed, 54 insertions(+), 3 deletions(-)

-- 
1.7.9.5
