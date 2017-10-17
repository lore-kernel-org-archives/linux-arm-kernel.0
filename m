From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 17 Oct 2017 20:17:26 +0200
Subject: [GIT PULL] Rockchip dts64 Fixes for 4.14 part 2
Message-ID: <6151423.bSX8Os9Bvg@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

looks like I need two rounds of fixes this time around.
But the vqmmc voltage issue warrants that I think, especially
as 4.14 is going to be a LTS release.

Please pull.

Thanks
Heiko

The following changes since commit 0bc15d85d97d44e8979ff91d0c1fbafe6fd4172c:

  arm64: dts: rockchip: add the grf clk for dw-mipi-dsi on rk3399 (2017-09-26 15:59:17 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.14-rockchip-dts64fixes-2

for you to fetch changes up to b521102d935d0501f5d95242ade2988f3f069c77:

  arm64: dts: rockchip: fix typo in iommu nodes (2017-10-17 20:13:52 +0200)

----------------------------------------------------------------
The vqmmc voltages on rk3399 pose a risk for the chip if they
exceed 3.0V, so they got fixed to not be at 3.3V
And Arnd found a typo in the recently added iommu nodes.

----------------------------------------------------------------
Arnd Bergmann (1):
      arm64: dts: rockchip: fix typo in iommu nodes

Shawn Lin (1):
      arm64: dts: rockchip: correct vqmmc voltage for rk3399 platforms

 arch/arm64/boot/dts/rockchip/rk3328.dtsi          | 2 +-
 arch/arm64/boot/dts/rockchip/rk3368.dtsi          | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399-firefly.dts   | 4 ++--
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi     | 4 ++--
 arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi | 4 ++--
 5 files changed, 8 insertions(+), 8 deletions(-)
