From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 01 Jul 2016 02:22:19 +0200
Subject: [GIT PULL 2/2] Rockchip dts64 changes for 4.8
In-Reply-To: <1666093.aVfPg2VmbT@phil>
References: <1666093.aVfPg2VmbT@phil>
Message-ID: <5006101.OhzRdW27q2@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

please find below arm64 devicetree changes for 4.8.

Some new things for the rk3399 like emmc support as well some
improvements+fixes for the rk3368 as explained in the tag.

So if ok, please pull

Thanks
Heiko


The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.8-rockchip-dts64-1

for you to fetch changes up to 5d26ad9cfb2ebe2aba75342813e7542d5a68d644:

  arm64: dts: rockchip: add ap_pwroff and ddrio_pwroff pins for rk3399 (2016-06-27 01:07:40 +0200)

----------------------------------------------------------------
The rk3399 gets support for its emmc controller as well as thermal,
i2c and core io-domain nodes and some reasonable default rates
for core clocks. The rk3368 also gets io-domains for its r88 board
as well as a small fix for the gic's memory regions.

----------------------------------------------------------------
Brian Norris (3):
      arm64: dts: rockchip: make rk3399's grf a "simple-mfd"
      arm64: dts: rockchip: add sdhci/emmc for rk3399
      arm64: dts: rockchip: enable eMMC for rk3399 EVB

Caesar Wang (2):
      arm64: dts: rockchip: add thermal nodes for rk3399 SoCs
      arm64: dts: rockchip: fixes the gic400 2nd region size for rk3368

David Wu (1):
      arm64: dts: rockchip: add i2c nodes for rk3399

Douglas Anderson (3):
      arm64: dts: rockchip: Add soc-ctl-syscon to sdhci for rk3399
      arm64: dts: rockchip: Provide emmcclk to PHY for rk3399
      arm64: dts: rockchip: add ap_pwroff and ddrio_pwroff pins for rk3399

Heiko Stuebner (4):
      arm64: dts: rockchip: make rk3368 grf syscons simple-mfds
      arm64: dts: rockchip: add rk3368 io-domain core nodes
      arm64: dts: rockchip: add rk3368-r88 iodomains
      arm64: dts: rockchip: add rk3399 io-domain core nodes

Xing Zheng (1):
      arm64: dts: rockchip: assign default rates for core rk3399 clocks

 arch/arm64/boot/dts/rockchip/rk3368-r88.dts |  16 ++
 arch/arm64/boot/dts/rockchip/rk3368.dtsi    |  16 +-
 arch/arm64/boot/dts/rockchip/rk3399-evb.dts |  12 ++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi    | 313 +++++++++++++++++++++++++++-
 4 files changed, 352 insertions(+), 5 deletions(-)
