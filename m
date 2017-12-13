From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 13 Dec 2017 07:57:08 +0100
Subject: [GIT PULL 2/2] Rockchip dts64 fixes for 4.15
In-Reply-To: <6469701.IcmEy0bVhn@phil>
References: <6469701.IcmEy0bVhn@phil>
Message-ID: <2690908.kxVfvpsLEa@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.15-rockchip-dts64fixes-1

for you to fetch changes up to bc631943faba6fc3f755748091ada31798fb7d50:

  arm64: dts: rockchip: limit rk3328-rock64 gmac speed to 100MBit for now (2017-12-06 01:14:20 +0100)

----------------------------------------------------------------
Another trailing interrupt-cell 0 removed.

Removed as well got the vdd_log regulator from the rk3399-puma board.
While it is there, the absence of any user makes it prone to configuration
problems when the pwm-regulator takes over the boot-up default and wiggles
settings there. Case in question was the PCIe host not working anymore.
With vdd_log removed for the time being, PCIe on Puma works again.

And a second stopgap is limiting the speed of the gmac on the rk3328-rock64
to 100MBit. While the hardware can reach 1GBit, currently it is not stable.
Limiting it to 100MBit for the time being allows nfsroots to be used again
until the problem is identified.

----------------------------------------------------------------
Heiko Stuebner (2):
      arm64: dts: rockchip: fix trailing 0 in rk3328 tsadc interrupts
      arm64: dts: rockchip: limit rk3328-rock64 gmac speed to 100MBit for now

Klaus Goger (1):
      arm64: dts: rockchip: remove vdd_log from rk3399-puma

 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts |  2 ++
 arch/arm64/boot/dts/rockchip/rk3328.dtsi       |  2 +-
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi  | 11 -----------
 3 files changed, 3 insertions(+), 12 deletions(-)
