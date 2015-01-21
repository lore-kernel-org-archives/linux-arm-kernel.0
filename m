From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 21 Jan 2015 22:49:27 +0100
Subject: [GIT PULL 1/2] ARM: rockchip: soc updates for 3.20
Message-ID: <2314612.MtoMVTtzSS@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

both pull requests mainly contain the new (basic) suspend support for
rk3288 and two small fixes. One is the limitting of the sd clock on rk3288
and the second is the removal of the Cortex-A9 reference from the board
name.

So if it looks ok, please pull


Thanks
Heiko


The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v3.20-rockchip-soc1

for you to fetch changes up to 8c4212418b54f360b21cf37b9caa1a226eb420f2:

  ARM: rockchip: remove cpu-core name from machine name (2015-01-21 21:00:39 +0100)

----------------------------------------------------------------
SoC parts of basic suspend support and removal of
Cortex-A9 reference from the machine name.

----------------------------------------------------------------
Chris Zhong (2):
      ARM: rockchip: add suspend and resume for RK3288
      ARM: rockchip: Add pmu-sram binding

Heiko Stuebner (1):
      ARM: rockchip: remove cpu-core name from machine name

 .../devicetree/bindings/arm/rockchip/pmu-sram.txt  |  16 ++
 arch/arm/mach-rockchip/Makefile                    |   1 +
 arch/arm/mach-rockchip/pm.c                        | 260 +++++++++++++++++++++
 arch/arm/mach-rockchip/pm.h                        |  99 ++++++++
 arch/arm/mach-rockchip/rockchip.c                  |   4 +-
 arch/arm/mach-rockchip/sleep.S                     |  73 ++++++
 6 files changed, 452 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/rockchip/pmu-sram.txt
 create mode 100644 arch/arm/mach-rockchip/pm.c
 create mode 100644 arch/arm/mach-rockchip/pm.h
 create mode 100644 arch/arm/mach-rockchip/sleep.S
