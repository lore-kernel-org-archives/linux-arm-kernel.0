From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 29 Sep 2014 11:42:44 +0200
Subject: [GIT PULL 1/2] ARM: rockchip: cpu regulators and OPPs
Message-ID: <7172632.O1FfdvXn6k@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

the corresponding clk changes made their way into the clock tree, so these
changes add the necessary supplies, operating points and clocks to rockchip
boards to enable cpu frequency scaling.

This pull request already includes commit
    4d742e6230b5 ("clk: rockchip: add binding id for ARMCLK")
that is shared with the clock tree [0].

[0] http://git.linaro.org/people/mike.turquette/linux.git/commit/4d742e6230b5ff157422d91d6ae8d2fc1303eb28

So please pull


The following changes since commit 6051ddd4f94894cce8fde3aa29f90ae6c567fc46:

  ARM: dts: rockchip: Remove "regulator-always-on" in vcc_rmii for Radxa Rock (2014-09-22 11:53:39 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v3.18-rockchip-dts3

for you to fetch changes up to 8848623b8c032ce7c41549ec743f8367c877d7f2:

  ARM: dts: rockchip: add cpu supplies to boards (2014-09-28 13:14:56 +0200)

----------------------------------------------------------------
CPU opp and board supplies for Rockchip boards.

----------------------------------------------------------------
Heiko Stuebner (4):
      clk: rockchip: add binding id for ARMCLK
      Merge branch 'v3.18-next/armclkid' into v3.18-next/dts
      ARM: dts: rockchip: add operating points and armclk references
      ARM: dts: rockchip: add cpu supplies to boards

 arch/arm/boot/dts/rk3066a-bqcurie2.dts        |  4 ++++
 arch/arm/boot/dts/rk3066a.dtsi                | 12 +++++++++++-
 arch/arm/boot/dts/rk3188-radxarock.dts        |  6 +++++-
 arch/arm/boot/dts/rk3188.dtsi                 | 15 ++++++++++++++-
 arch/arm/boot/dts/rk3288-evb-rk808.dts        |  6 +++++-
 arch/arm/boot/dts/rk3288.dtsi                 | 19 ++++++++++++++++++-
 include/dt-bindings/clock/rk3188-cru-common.h |  1 +
 include/dt-bindings/clock/rk3288-cru.h        |  1 +
 8 files changed, 59 insertions(+), 5 deletions(-)
