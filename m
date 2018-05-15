From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 15 May 2018 12:39:26 +0200
Subject: [GIT PULL 3/4] Rockchip dts64 updates for 4.18 round 1
In-Reply-To: <2000491.bLgWuj0xar@phil>
References: <2000491.bLgWuj0xar@phil>
Message-ID: <20114925.REm1YfjZS7@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.18-rockchip-dts64-1

for you to fetch changes up to 17bd0737948aa841b76278a601217b914aa5f18e:

  arm64: dts: rockchip: enable hdmi on rk3399-puma-haikou (2018-05-03 14:38:20 +0200)

----------------------------------------------------------------
All iommus got their clocks added and rk3399 got support for its
usb3-phy otg-port and better ajustment for the cpll child clocks.
On the board side, all rk3399 got their typec phys enabled - which
is needed for better usb support, the sapphire board got some more
properties moved to the excavator baseboard where they really belong,
kevin got a fix to use a real devicetree compatible and puma-haikou
got its hdmi port enabled.

----------------------------------------------------------------
Dmitry Torokhov (1):
      arm64: dts: rockchip: use canonical compatible for touchpad/touchscreen on gru-kevin

Enric Balletbo i Serra (5):
      arm64: dts: rockchip: enable typec-phy for rk3399-sapphire
      arm64: dts: rockchip: enable typec-phy for rk3399-firefly
      arm64: dts: rockchip: enable typec-phy1 for rk3399-puma
      arm64: dts: rockchip: enable typec-phy0 for rk3399-puma-haikou
      arm64: dts: rockchip: add usb3-phy otg-port support for rk3399

Jakob Unterwurzacher (1):
      arm64: dts: rockchip: enable hdmi on rk3399-puma-haikou

Jeffy Chen (1):
      arm64: dts: rockchip: add clocks in iommu nodes

Lin Huang (1):
      arm64: dts: rockchip: assign clock rate for cpll child clocks on rk3399

Vicente Bergas (2):
      arm64: dts: rockchip: move rk3399-sapphire PCIe to excavator baseboard
      arm64: dts: rockchip: remove PCIe assigned-clocks in excavator baseboard

 arch/arm64/boot/dts/rockchip/rk3328.dtsi           | 10 ++++++
 arch/arm64/boot/dts/rockchip/rk3368.dtsi           | 10 ++++++
 arch/arm64/boot/dts/rockchip/rk3399-firefly.dts    |  8 +++++
 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts  |  4 +--
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi       |  8 +++--
 .../arm64/boot/dts/rockchip/rk3399-puma-haikou.dts | 25 +++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi      |  4 +++
 .../dts/rockchip/rk3399-sapphire-excavator.dts     | 12 ++++++++
 arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi  | 23 +++++---------
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           | 36 ++++++++++++++++------
 10 files changed, 111 insertions(+), 29 deletions(-)
