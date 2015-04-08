From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 09 Apr 2015 01:28:24 +0200
Subject: [GIT PULL] ARM: dts: rockchip: small bunch of improvements,
 maybe still for 4.1
Message-ID: <1461099.EW9lnJUZxa@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

these are 4 small dts improvements, two of which where waiting for
dependend patches to go into the respective maintainer trees.
I don't think there is something controversial in here, but it still
might be to late for 4.1, if so I'll repost these for 4.2 instead.


Thanks
Heiko


The following changes since commit 91d5cb737287642b75e47790a28a43cd0efd80cb:

  ARM: dts: rockchip: complete rk3288-evb pmic supplies (2015-03-13 00:07:39 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.1-rockchip-dts2

for you to fetch changes up to 98febfbeb99dc0cb1409099eba0e93d0cab12843:

  ARM: dts: rockchip: enable tsadc on rk3288 boards (2015-04-07 23:28:51 +0200)

----------------------------------------------------------------
Some more quite small changes. Enabling the tsadc on the other
supported rk3288 boards besides the rk3288-evb, the firefly board
needs a hym8563 fix that was accepted into the mm-tree.
Adding the act8846 supplies for the firefly board, which where
somehow forgotten.
Also the addition of the cortex-a12-pmu dt node and the sdmmc supplies
on the rk3288-evb which now do not produce deferal errors anymore
thanks to a patch going through the mmc tree.

----------------------------------------------------------------
Doug Anderson (1):
      ARM: dts: rockchip: Specify VMMC and VQMMC on rk3288-evb

Heiko Stuebner (2):
      ARM: dts: rockchip: add act8846 supplies on rk3288-firefly
      ARM: dts: rockchip: enable tsadc on rk3288 boards

Sonny Rao (1):
      arm: dts: rockchip: Enable Cortex-A12 HW PMU events on rk3288

 arch/arm/boot/dts/rk3288-evb.dtsi     | 23 +++++++++++++++++++++++
 arch/arm/boot/dts/rk3288-firefly.dtsi | 14 ++++++++++++++
 arch/arm/boot/dts/rk3288-popmetal.dts |  6 ++++++
 arch/arm/boot/dts/rk3288.dtsi         |  8 ++++++++
 4 files changed, 51 insertions(+)
