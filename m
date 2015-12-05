From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 05 Dec 2015 01:53:38 +0100
Subject: [GIT PULL 1/3] rockchip soc changes for 4.5
Message-ID: <1936935.FVZdWRYuBf@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

please find below rockchip soc changes for 4.5 .

There exists one possible merge conflict with armsoc/cleanup, due to the newly
added const/__initconst attributes in the smp_operations.

But I've already also adapted the new smp operation struct accordingly.


The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.5-rockchip-soc

for you to fetch changes up to 24fdb345d7a9e1ee8dc6fe138a250c63f918fed5:

  ARM: rockchip: use const and __initconst for rk3036 smp_operations (2015-12-04 18:36:02 +0100)

----------------------------------------------------------------
SMP special case for the rk3036 and making sure the arch-timer
supply is enabled, similar to the rk3288.

----------------------------------------------------------------
Heiko Stuebner (2):
      ARM: rockchip: add support smp for rk3036
      ARM: rockchip: use const and __initconst for rk3036 smp_operations

Xing Zheng (1):
      ARM: rockchip: make sure timer5 is enabled on rk3036 platforms

 Documentation/devicetree/bindings/arm/cpus.txt |  1 +
 arch/arm/mach-rockchip/platsmp.c               | 45 +++++++++++++++++++-------
 arch/arm/mach-rockchip/rockchip.c              | 44 +++++++++++++++----------
 3 files changed, 61 insertions(+), 29 deletions(-)
