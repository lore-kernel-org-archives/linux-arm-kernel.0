From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 24 Aug 2017 10:41:29 +0200
Subject: [GIT PULL 1/2] second round of Rockchip dts64 changes for 4.14
Message-ID: <4088347.CX4PhsiguF@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

please find below some more Rockchip related changes, that hopfully can
still make it into 4.14. Nothing overly exciting, just some more boards and
new nodes.

This also includes the core graphics support for rk3399 and the new sapphire
board from Rockchip also includes working graphic support already.
I was also able to get hdmi output on the rk3399-firefly, but as this was only
yesterday I didn't want to rush changes to much, but might include it in a
third round, if Linus does an -rc8. Otherwise it doesn't really hurt to wait
one release.

So, please pull.


Thanks
Heiko


The following changes since commit 45a995c054e116ea9578dd6186be35f65cc0a7d0:

  arm64: dts: rockchip: update dynamic-power-coefficient for rk3399 (2017-08-01 01:00:55 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.14-rockchip-dts64-2

for you to fetch changes up to 60fd9f72ce8a353f6371101c788e4d86212b16d7:

  arm64: dts: rockchip: add Haikou baseboard with RK3399-Q7 SoM (2017-08-23 09:40:05 +0200)

----------------------------------------------------------------
3 new boards, the rk3328-based Rock64 from the Pine64-makers, the
Sapphire som+baseboard which is another evaluation board for Rocckhip
customers and the rk3399-based som+baseboard from Austria-based
Theobroma Systems, which interestingly is in a miniITX formfactor
and provides a real PCIe x4 slot.

New nodes include on rk3399 graphics (vops, hdmi, etc) and more iommus,
on rk3328 iommus, pwm, thermal management, and sound as well as operating
points and rk3368 got iommu nodes and cpu operating points.

On existing boards firefly got operating points, the rk3328-evb got its
pmic and gru boards got some sound-related fixes.

----------------------------------------------------------------
David Wu (1):
      arm64: dts: rockchip: Add pwm nodes for rk3328

Elaine Zhang (1):
      arm64: dts: rockchip: add pd_edp node for rk3399

Finley Xiao (1):
      arm64: dts: rockchip: Add cpu operating points for RK3328 SoC

Heiko Stuebner (2):
      arm64: dts: rockchip: remove num-slots property from rk3399-sapphire
      arm64: dts: rockchip: add rk3328-rock64 board

Jacob Chen (4):
      arm64: dts: rockchip: add rk3399 mipi nodes
      arm64: dts: rockchip: add rk3399 hdmi nodes
      arm64: dts: rockchip: Add support for rk3399 sapphire SOM
      arm64: dts: rockchip: Add support for rk3399 excavator main board

Jeffy Chen (2):
      arm64: dts: rockchip: Fix wrong rt5514 dmic delay property for Gru
      arm64: dts: rockchip: Assign mic irq to correct device for Gru

Jianqun Xu (1):
      arm64: dts: rockchip: include opp dtsi for rk3399 firefly

Joseph Chen (1):
      arm64: dts: rockchip: add rk805 node for rk3328-evb

Kever Yang (1):
      arm64: dts: rockchip: init rk3399 vop clock rates

Klaus Goger (3):
      dt-bindings: add rk3399-q7 SoM
      arm64: dts: rockchip: add RK3399-Q7 (Puma) SoM
      arm64: dts: rockchip: add Haikou baseboard with RK3399-Q7 SoM

Mark Yao (1):
      arm64: dts: rockchip: Add rk3399 vop and display-subsystem

Rocky Hao (3):
      arm64: dts: rockchip: add tsadc node for rk3328 SoC
      arm64: dts: rockchip: add thermal nodes for rk3328 SoC
      arm64: dts: rockchip: Enable tsadc module on RK3328 eavluation board

Romain Perier (1):
      arm64: dts: rockchip: Add basic cpu frequencies for RK3368

Simon Xue (3):
      arm64: dts: rockchip: add rk3328 iommu nodes
      arm64: dts: rockchip: add rk3368 iommu nodes
      arm64: dts: rockchip: add more rk3399 iommu nodes

Sugar Zhang (2):
      arm64: dts: rockchip: add rk3328 i2s nodes
      arm64: dts: rockchip: add rk3328 pdm node

William Wu (1):
      arm64: dts: rockchip: disable tx ipgap linecheck for rk3399 dwc3

Yakir Yang (1):
      arm64: dts: rockchip: add rk3399 edp nodes

 Documentation/devicetree/bindings/arm/rockchip.txt |  12 +
 arch/arm64/boot/dts/rockchip/Makefile              |   3 +
 arch/arm64/boot/dts/rockchip/rk3328-evb.dts        | 140 +++++
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts     | 333 +++++++++++
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           | 304 ++++++++++
 arch/arm64/boot/dts/rockchip/rk3368.dtsi           | 121 +++-
 arch/arm64/boot/dts/rockchip/rk3399-firefly.dts    |   1 +
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi       |  13 +-
 .../arm64/boot/dts/rockchip/rk3399-puma-haikou.dts | 228 ++++++++
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi      | 547 +++++++++++++++++
 .../dts/rockchip/rk3399-sapphire-excavator.dts     | 240 ++++++++
 arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi  | 644 +++++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           | 243 ++++++++
 13 files changed, 2820 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
