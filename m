From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Thu, 08 May 2014 16:07:55 +0530
Subject: [PATCH v2 0/4] ARM: dts: enable hdmi for exynos5 based peach and snow
 boards
Message-ID: <1399545479-20086-1-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rahul Sharma <Rahul.Sharma@samsung.com>

Enable hdmi for exynos5250 based snow board and exynos5420
based peach pit board. It also adds properties to hdmi nodes
for accessing hdmiphy as simple phys.

V2:
1) Re-spin on dependent patches.
2) Added patch to remove chip specific hdmi hpd gpio from
board file top SoC file.

This series is based on Kukjin Kims, for-next branch.

It is dependent on
1) Arun's patch for adding peach-pit board dts file at
http://www.spinics.net/lists/linux-samsung-soc/msg30103.html. [Patch is 'ACK'ed.]
2) Sachin's patch for snow board dts file at
https://patches.linaro.org/28325/
3) DRM Hdmi driver patch which is changing the DT bioding at
http://www.spinics.net/lists/linux-samsung-soc/msg28052.html

Rahul Sharma (4):
  ARM: dts: enable hdmi for exynos5250 based snow board
  ARM: dts: change to correct compatible string for exynos5420 hdmi
  ARM: dts: enable hdmi for exynos5420 based peach-pit board
  ARM: dts: remove chip specific hdmi hpd pin from board

 arch/arm/boot/dts/exynos5250-cros-common.dtsi |    6 +++++-
 arch/arm/boot/dts/exynos5250-pinctrl.dtsi     |    7 +++++++
 arch/arm/boot/dts/exynos5250-snow.dts         |    7 +++++++
 arch/arm/boot/dts/exynos5420-peach-pit.dts    |   19 +++++++++++++++++++
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi     |    7 +++++++
 arch/arm/boot/dts/exynos5420-smdk5420.dts     |    9 ---------
 arch/arm/boot/dts/exynos5420.dtsi             |    7 ++++++-
 7 files changed, 51 insertions(+), 11 deletions(-)

-- 
1.7.9.5
