From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 06 Mar 2013 18:06:36 +0530
Subject: [PATCH 0/2] ARM: dts: Add default pin states for client nodes on
 Exynos4/5 platforms
Message-ID: <1362573398-15126-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series populates the default pin states in client nodes
of Exynos4 and Exynos5 platforms. Exynos4/5 platforms are migrating
to use pinctrl framework and having the default pin states listed
in the client nodes allows the device core to setup the default
pin configuration for all the controllers.

This means the old-styled Samsung specific gpio bindings, which have
been used till now for setting up the pin configurations, will not be
used anymore. The corresponding changes required in device drivers
have been posted seperatly.

Thomas Abraham (2):
  ARM: dts: add pin state information in client nodes for Exynos4 platforms
  ARM: dts: add pin state information in client nodes for Exynos5 platforms

 arch/arm/boot/dts/cros5250-common.dtsi    |   51 +--
 arch/arm/boot/dts/exynos4.dtsi            |   10 +
 arch/arm/boot/dts/exynos4210-smdkv310.dts |   53 +--
 arch/arm/boot/dts/exynos5250-pinctrl.dtsi |  783 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos5250-smdk5250.dts |   33 +-
 arch/arm/boot/dts/exynos5250-snow.dts     |   22 +-
 arch/arm/boot/dts/exynos5250.dtsi         |  310 +++---------
 7 files changed, 923 insertions(+), 339 deletions(-)
 create mode 100755 arch/arm/boot/dts/exynos5250-pinctrl.dtsi
