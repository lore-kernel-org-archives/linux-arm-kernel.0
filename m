From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 15 Mar 2018 23:22:24 +0100
Subject: [GIT PULL 3/4] Rockchip dts32 changes for 4.17
In-Reply-To: <12470502.BUvxkRrZk8@phil>
References: <12470502.BUvxkRrZk8@phil>
Message-ID: <1841402.lINMpr9JsG@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.17-rockchip-dts32-1

for you to fetch changes up to 8dc9b9720380a3c16969932151ba92b558110b2f:

  ARM: dts: rockchip: enable USB-OTG port on Radxa Rock2 Square (2018-02-19 06:53:35 +0100)

----------------------------------------------------------------
For general soc-specific changes the rk322x socs got their correct grf
compatible set. Other than that there are some board-specific changes
like the Rock2 getting its otg port, recovery and power keys enabled.

The vyasa board gained an enabled emmc node and the phyCORE boards
got UHS speeds in their sd card and a fixed sd-card power supply.

Finally the veyron boards dropped a nonstandard and unused property.

----------------------------------------------------------------
Brian Norris (1):
      ARM: dts: rockchip: drop veyron's nonstandard 'backlight-boot-off'

Jagan Teki (1):
      ARM: dts: rockchip: Add eMMC node for rk3288-vyasa

John Keeping (3):
      ARM: dts: rockchip: add power key for Rock2 Square
      ARM: dts: rockchip: add recovery button for Rock2 Square
      ARM: dts: rockchip: enable USB-OTG port on Radxa Rock2 Square

Shawn Lin (1):
      ARM: dts: rockchip: add "rockchip,rk3228-grf" compatible for rk322x grf node

Wadim Egorov (2):
      ARM: dts: rockchip: Fix supply node for card's power on phycore som
      ARM: dts: rockchip: Support UHS mode for SD card on phyCORE-RK3288 RDK

 arch/arm/boot/dts/rk322x.dtsi                   |  2 +-
 arch/arm/boot/dts/rk3288-phycore-rdk.dts        |  6 +++-
 arch/arm/boot/dts/rk3288-phycore-som.dtsi       |  5 ++-
 arch/arm/boot/dts/rk3288-rock2-som.dtsi         |  4 +++
 arch/arm/boot/dts/rk3288-rock2-square.dts       | 41 +++++++++++++++++++++++++
 arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi |  1 -
 arch/arm/boot/dts/rk3288-vyasa.dts              | 11 +++++++
 7 files changed, 64 insertions(+), 6 deletions(-)
