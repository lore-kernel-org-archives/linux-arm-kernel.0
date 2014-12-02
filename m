From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 02 Dec 2014 18:10:28 +0100
Subject: [GIT PULL] last dts changes for 3.19
Message-ID: <2096313.yXUQoznUHp@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof

Some more small devicetree changes, hopefully still in time for 3.19.

Biggest chunk is probably the enablement of the rk3288 thermal driver
that got accepted last week [0].

Apart from that there is small stuff as the tag-messages shows.

So if this is small enough, please pull


Thanks
Heiko


[0] https://git.kernel.org/cgit/linux/kernel/git/evalenti/linux-soc-thermal.git/commit/?id=cbac8f63943773218f7f804754209aaa4fae33f9


The following changes since commit b77d43943ea83997c6c37b8831d1561981d499c5:

  ARM: dts: rockchip: temporarily disable smp on rk3288 (2014-11-22 16:23:28 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v3.19-rockchip-dts4

for you to fetch changes up to 288ce4a8b67795543c69ca6c52f429de24036296:

  ARM: dts: rockchip: Add input voltage supply regulators in pmic for Marsboard (2014-12-02 17:58:39 +0100)

----------------------------------------------------------------
- rk3288 thermal driver that got accepted into the thermal tree
- mmc fifo sizes for Cortex-A9 SoCs
- labels for the leds on the RadxaRock
- core system supply for the Marsboard

----------------------------------------------------------------
Caesar Wang (3):
      ARM: dts: rockchip: add RK3288 Thermal data
      ARM: dts: rockchip: add main thermal info to rk3288
      ARM: dts: rockchip: enable thermal on rk3288-evb board

Julien CHAUVEAU (1):
      ARM: dts: rockchip: set FIFO size for SDMMC, SDIO and EMMC on rk3066 and rk3188

Romain Perier (2):
      ARM: dts: rockchip: add label property for leds on Radxa Rock
      ARM: dts: rockchip: Add input voltage supply regulators in pmic for Marsboard

 arch/arm/boot/dts/rk3066a-marsboard.dts | 14 +++++++
 arch/arm/boot/dts/rk3188-radxarock.dts  |  5 ++-
 arch/arm/boot/dts/rk3288-evb.dtsi       |  6 +++
 arch/arm/boot/dts/rk3288-thermal.dtsi   | 74 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/rk3288.dtsi           | 27 ++++++++++++
 arch/arm/boot/dts/rk3xxx.dtsi           |  9 ++--
 6 files changed, 128 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/boot/dts/rk3288-thermal.dtsi
