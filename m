From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 20 Dec 2013 11:07:23 -0700
Subject: [GIT PULL 1/2] ARM: tegra: second set of device tree changes
Message-ID: <1387562844-32497-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This branch contains changes to Tegra's device tree that came in after
I sent the previous pull-request/tag tegra-for-3.14-dt. Changes are:

* Set up aliases for RTCs, so that the correct RTC is chosen to
  initialize the system date/time.
* Venice2 pinctrl and regulator configuration.
* Built-in panel enablement for Harmony, Cardhu, Dalmore.
* HDMI enablement for Dalmore.
* USB2 port enablement for Beaver.
* Keyboard and power key enablement for Venice2.

This branch is based on tag tegra-for-3.14-dt, for which I sent a
previous pull request.

----------------------------------------------------------------

The following changes since commit 9f1ac5606a008f4849208ebfe818f979619dced0:

  ARM: tegra: Add SPI controller nodes for Tegra124

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tegra-for-3.14-dt-2

for you to fetch changes up to 3f748d44503bd7ead26acf938f5a0bf845cea515:

  ARM: tegra: Enable power key on Venice2

----------------------------------------------------------------

Eric Brower (2):
      ARM: tegra: modify Tegra30 USB2 default phy_type to UTMI
      ARM: tegra: enable USB2 on Tegra30 Beaver

Laxman Dewangan (2):
      ARM: tegra: fix missing pincontrol configuration for Venice2
      ARM: tegra: add ams AS3722 device to Venice2 DT

Mikko Perttunen (2):
      ARM: tegra: Add host1x, DC and HDMI to Tegra114 device tree
      ARM: tegra: Enable HDMI support on Dalmore

Stephen Warren (2):
      ARM: tegra: set up /aliases entries for RTCs
      ARM: tegra: set up /aliases for RTCs on Venice2

Thierry Reding (9):
      ARM: tegra: Enable LVDS on Harmony
      ARM: tegra: Enable LVDS on Cardhu
      ARM: tegra: Add MIPI calibration DT entries for Tegra114
      ARM: tegra: Add Tegra114 DSI support
      ARM: tegra: Add Tegra114 gr2d support
      ARM: tegra: Add Tegra114 gr3d support
      ARM: tegra: Enable DSI support on Dalmore
      ARM: tegra: Enable Venice2 keyboard
      ARM: tegra: Enable power key on Venice2

 arch/arm/boot/dts/tegra114-dalmore.dts     |  64 ++-
 arch/arm/boot/dts/tegra114.dtsi            | 113 ++++
 arch/arm/boot/dts/tegra124-venice2.dts     | 729 ++++++++++++++++++++++--
 arch/arm/boot/dts/tegra20-colibri-512.dtsi |   5 +
 arch/arm/boot/dts/tegra20-harmony.dts      |  41 +-
 arch/arm/boot/dts/tegra20-paz00.dts        |   5 +
 arch/arm/boot/dts/tegra20-seaboard.dts     |   5 +
 arch/arm/boot/dts/tegra20-tamonten.dtsi    |   5 +
 arch/arm/boot/dts/tegra20-trimslice.dts    |   5 +
 arch/arm/boot/dts/tegra20-ventana.dts      |   5 +
 arch/arm/boot/dts/tegra20-whistler.dts     |   5 +
 arch/arm/boot/dts/tegra30-beaver.dts       |  14 +
 arch/arm/boot/dts/tegra30-cardhu.dtsi      |  42 +-
 arch/arm/boot/dts/tegra30.dtsi             |  21 +-
 14 files changed, 990 insertions(+), 69 deletions(-)
