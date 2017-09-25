From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 25 Sep 2017 19:17:12 +0200
Subject: [GIT PULL] Rockchip dts64 Fixes for 4.14
Message-ID: <6990785.aOlALvEuSf@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

please find below two fixes for 64bit Rockchip devicetrees.

As the tag explains the main change is the revert of the rk3368 opp
addition, as this cannot safely run on current rk3368 boards and thus
shouldn't make a kernel release.


Please pull, thanks
Heiko


The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.14-rockchip-dts64fixes-1

for you to fetch changes up to bb4e6ff01ac356f82327d980e45fee8a65491328:

  arm64: dts: rockchip: Correct MIPI DPHY PLL clock on rk3399 (2017-09-19 19:25:10 +0200)

----------------------------------------------------------------
Adding the operating points on rk3368 like they were did not end up well
for the boards as all of them are missing their cpu supplies, the opps
actually need to follow the <target min max> format as the regulator is
shared between both clusters and the one rk3368 board I have, somehow also
doesn't like the higher opps at all - all of which I only realized after
I brought my rk3368 board online again, after its bootloader broke.

And a fix for the mipi dsi controller on rk3399, which was referencing
a clock to high up in the clock-tree so that an intermediate gate could
be disabled inadvertently.
rk3368-board I have in my farm did not like the h

----------------------------------------------------------------
Heiko Stuebner (1):
      Revert "arm64: dts: rockchip: Add basic cpu frequencies for RK3368"

Nickey Yang (1):
      arm64: dts: rockchip: Correct MIPI DPHY PLL clock on rk3399

 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 72 +-------------------------------
 arch/arm64/boot/dts/rockchip/rk3399.dtsi |  2 +-
 2 files changed, 3 insertions(+), 71 deletions(-)
