From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 21 Oct 2013 07:15:39 +0900
Subject: [GIT PULL 6/6] Samsung update for v3.13
Message-ID: <5264560B.504@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 4a10c2ac2f368583138b774ca41fac4207911983:

   Linux 3.12-rc2 (2013-09-23 15:41:09 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/exynos-dt

for you to fetch changes up to c6ad2259c629bef992be5ee82d3e74cd1e90c440:

   ARM: dts: disable PCIe for SD5v1 board (2013-10-08 06:58:01 +0900)

----------------------------------------------------------------
update device tree for exynos
- add MIPI PHY node for exynos4
- update regulator for origen and exynos5250-arndale
- add support HDMI for exynos5250, exynos5420
- disable PCIe for exynos5440-sd5v1

----------------------------------------------------------------
Andrew Bresticker (1):
       ARM: dts: add i2c device nodes for Exynos5420

Jingoo Han (1):
       ARM: dts: disable PCIe for SD5v1 board

Mark Brown (1):
       ARM: dts: Disable Exynos5250 I2S controllers by default

Rahul Sharma (4):
       of/documentation: update with clock information for exynos hdmi 
subsystem
       ARM: dts: add clocks to hdmi dt node for exynos5250
       ARM: dts: add dt nodes for hdmi subsystem for exynos5420
       ARM: dts: enable hdmi subsystem for exynos5420 smdk board

Sachin Kamat (3):
       ARM: dts: Add fixed voltage regulator to simple bus for origen
       ARM: dts: Add reg property to regulator nodes in exynos5250-arndale
       ARM: dts: Add HDMI related I2C nodes for Arndale board

Sean Paul (1):
       ARM: dts: add mixer clocks to mixer node for Exynos5250

Sylwester Nawrocki (1):
       ARM: dts: Add MIPI PHY node to exynos4.dtsi

  .../devicetree/bindings/video/exynos_hdmi.txt      | 14 +++-
  .../devicetree/bindings/video/exynos_mixer.txt     |  4 ++
  arch/arm/boot/dts/exynos4.dtsi                     | 10 +++
  arch/arm/boot/dts/exynos4210-origen.dts            | 21 ++++--
  arch/arm/boot/dts/exynos4412-origen.dts            | 21 ++++--
  arch/arm/boot/dts/exynos5250-arndale.dts           | 33 ++++++++--
  arch/arm/boot/dts/exynos5250-smdk5250.dts          |  8 ---
  arch/arm/boot/dts/exynos5250.dtsi                  | 11 +++-
  arch/arm/boot/dts/exynos5420-smdk5420.dts          | 26 ++++++++
  arch/arm/boot/dts/exynos5420.dtsi                  | 75 
++++++++++++++++++++++
  arch/arm/boot/dts/exynos5440-sd5v1.dts             |  7 ++
  11 files changed, 200 insertions(+), 30 deletions(-)
