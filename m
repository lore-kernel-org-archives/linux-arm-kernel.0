From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 11 Jul 2018 16:29:29 +0200
Subject: [GIT PULL 2/2] Rockchip dts64 updates for 4.19 round 1
In-Reply-To: <1895379.zdtPBogyMs@phil>
References: <2000491.bLgWuj0xar@phil> <1895379.zdtPBogyMs@phil>
Message-ID: <3426970.u8yLmZCROa@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.19-rockchip-dts64-1

for you to fetch changes up to d0414fdd58eb51ffd6528280fd66705123663964:

  arm64: dts: rockchip: corrected uart1 clock-names for rk3328 (2018-07-07 13:02:27 +0200)

----------------------------------------------------------------
SPDX conversion for existing devicetree files. New board is Gru-Bob
the Chromebook Flip C101PA which also got some stuff moved around
to make room for Scarlet once its display pipeline makes some more
advances.
Also included are some general sound improvements for rk3399
including enabling hdmi-sound on the sapphire board and some
misc fixes like missing cooling device properties and wrong
clock-names for the uart1 on rk3328.

----------------------------------------------------------------
Heiko Stuebner (5):
      arm64: dts: rockchip: generalize rk3399 #sound-dai-cells
      arm64: dts: rockchip: add phandles to some nodes on rk3399-gru
      arm64: dts: rockchip: move Chromebook-specific Gru-parts to a separate file
      arm64: dts: rockchip: move core edp from rk3399-kevin to shared chromebook
      arm64: dts: rockchip: add Google Bob

Huibin Hong (1):
      arm64: dts: rockchip: corrected uart1 clock-names for rk3328

Klaus Goger (1):
      arm64: dts: rockchip: use SPDX-License-Identifier

Randy Li (1):
      arm64: dts: rockchip: add some common pin-settings to rk3399

Vicente Bergas (2):
      arm64: dts: rockchip: connect hdmi sound in rk3399
      arm64: dts: rockchip: enable hdmi sound on rk3399-sapphire

Viresh Kumar (1):
      arm64: dts: rockchip: Add missing cooling device properties for CPUs

 Documentation/devicetree/bindings/arm/rockchip.txt |   9 +
 arch/arm64/boot/dts/rockchip/Makefile              |   1 +
 arch/arm64/boot/dts/rockchip/rk3328-evb.dts        |  39 +-
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts     |  39 +-
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |  44 +--
 .../arm64/boot/dts/rockchip/rk3368-evb-act8846.dts |  39 +-
 arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi       |  39 +-
 arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts    |  39 +-
 .../boot/dts/rockchip/rk3368-orion-r68-meta.dts    |  39 +-
 arch/arm64/boot/dts/rockchip/rk3368-px5-evb.dts    |  39 +-
 arch/arm64/boot/dts/rockchip/rk3368-r88.dts        |  39 +-
 arch/arm64/boot/dts/rockchip/rk3368.dtsi           |  47 +--
 arch/arm64/boot/dts/rockchip/rk3399-evb.dts        |  39 +-
 arch/arm64/boot/dts/rockchip/rk3399-firefly.dts    |  42 +--
 arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dts    |  79 ++++
 .../boot/dts/rockchip/rk3399-gru-chromebook.dtsi   | 397 +++++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts  |  86 +----
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi       | 367 +------------------
 arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi   |  39 +-
 arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi       |  39 +-
 .../arm64/boot/dts/rockchip/rk3399-puma-haikou.dts |  39 +-
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi      |  40 +--
 .../dts/rockchip/rk3399-sapphire-excavator.dts     |  41 +--
 arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi  |  44 +--
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           | 153 +++++---
 25 files changed, 627 insertions(+), 1191 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
