From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 08 Aug 2015 23:28:07 +0200
Subject: [GIT PULL 1/2] Rockchip soc changes for 4.3, part2
Message-ID: <3109032.sS4ICWceDv@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Kevin, Arnd,

here is round two of soc and devicetree changes for 4.3.

So if ok, please pull

Thanks
Heiko


The following changes since commit cb8cc37f4d38d96552f2c52deb15e511cdacf906:

  ARM: rockchip: fix broken build (2015-07-06 11:46:08 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.3-rockchip32-soc2

for you to fetch changes up to 9bb91ae970dd004393a3d7d09bdcc30dfe2f8693:

  ARM: rockchip: enable PMU_GPIOINT_WAKEUP_EN when entering shallow suspend (2015-08-06 13:05:14 +0200)

----------------------------------------------------------------
Improve reliability of resume on rk3288 boards. For whatever
reason resuming from suspend worked sucessfully on the rk3288-evb
but not on other boards, like veyron-devices. Two problems seem
to have existed. For one the stabilization delays for pmic and
oscillator may have been to short and secondly the shallow
suspend seems to need GPIO wakups enabled. Normally this should
be covered by the more generic ARMINT wakeups already and
the reason for this is still investigated at Rockchip, but
meanwhile this makes boards actually resume.

----------------------------------------------------------------
Heiko Stuebner (3):
      ARM: rockchip: rename osc_switch_to_32k variable
      ARM: rockchip: set correct stabilization thresholds in suspend
      ARM: rockchip: enable PMU_GPIOINT_WAKEUP_EN when entering shallow suspend

 arch/arm/mach-rockchip/pm.c | 35 +++++++++++++++++++++++++++--------
 arch/arm/mach-rockchip/pm.h |  5 +----
 2 files changed, 28 insertions(+), 12 deletions(-)
