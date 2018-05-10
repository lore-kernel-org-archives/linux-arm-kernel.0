From: djw@t-chip.com.cn (djw at t-chip.com.cn)
Date: Thu, 10 May 2018 17:16:35 +0800
Subject: [PATCH v1 0/5] Add sdmmc UHS support to ROC-RK3328-CC board.
Message-ID: <1525943800-14095-1-git-send-email-djw@t-chip.com.cn>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Levin Du <djw@t-chip.com.cn>

Hi all, this is an attemp to add sdmmc UHS support to the
ROC-RK3328-CC board.

This patch series adds a new compatible `rockchip,gpio-syscon` to
the gpio-syscon driver for general Rockchip SoC usage..

A new gpio controller named `gpio_syscon10` is defined in
rk3328.dtsi so that all rk3328 boards has access to it.

The ROC-RK3328-CC board use the new gpio <&gpio_syscon10 1> in
gpio-regulator to control the signal voltage of the sdmmc.
It is essential for UHS support which requires 1.8V signal voltage.

Many thanks to Heiko's great advice!

Changes in v1:
- Refactured for general gpio-syscon usage for Rockchip SoCs.
- Add doc rockchip,gpio-syscon.txt .
- Split into small patches.
- Add gpio-syscon10 to rk3328 for general use.
- Sort dts properties in sdmmc node.

Heiko Stuebner (1):
  gpio: syscon: allow fetching syscon from parent node

Levin Du (4):
  gpio: syscon: Add gpio-syscon for rockchip
  arm64: dts: rockchip: Add gpio-syscon10 to rk3328
  arm64: dts: rockchip: Add io-domain to roc-rk3328-cc
  arm64: dts: rockchip: Add sdmmc UHS support for roc-rk3328-cc

 .../bindings/gpio/rockchip,gpio-syscon.txt         | 41 ++++++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts     | 30 ++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |  6 ++++
 drivers/gpio/gpio-syscon.c                         | 32 +++++++++++++++++
 4 files changed, 109 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/rockchip,gpio-syscon.txt

-- 
2.7.4
