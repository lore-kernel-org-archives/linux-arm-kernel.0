From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 18 Feb 2018 16:41:31 +0100
Subject: [GIT PULL 2/2] Rockchip dts64 fixes for 4.16
In-Reply-To: <2137280.MWbT8y5lbZ@phil>
References: <2137280.MWbT8y5lbZ@phil>
Message-ID: <1708943.A4pxJccnVY@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.16-rockchip-dts64fixes-1

for you to fetch changes up to ca9eee95a2decc6f60bed65b5b836a26bff825c1:

  arm64: dts: rockchip: Fix DWMMC clocks (2018-02-16 10:30:25 +0100)

----------------------------------------------------------------
Fixes of dwmmc tuning clocks that may make probing HS cards fail,
adding the grf-vio clock to the edp so that it can also be build
as module, correct pcie ep-gpio on the sapphire board and finally
a fix that makes the gmac work at gigabit speeds on the rk3328-rock64.

----------------------------------------------------------------
Kamil Trzci?ski (1):
      arm64: dts: rockchip: fix rock64 gmac2io stability issues

Robin Murphy (1):
      arm64: dts: rockchip: Fix DWMMC clocks

Shawn Lin (1):
      arm64: dts: rockchip: correct ep-gpios for rk3399-sapphire

Yakir Yang (1):
      arm64: dts: rockchip: introduce pclk_vio_grf in rk3399-eDP device node

 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts    | 7 +++----
 arch/arm64/boot/dts/rockchip/rk3328.dtsi          | 6 +++---
 arch/arm64/boot/dts/rockchip/rk3368.dtsi          | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi          | 4 ++--
 5 files changed, 10 insertions(+), 11 deletions(-)
