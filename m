From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 25 Apr 2015 02:11:14 +0200
Subject: [GIT PULL] ARM: rockchip: some soc-level fixes for 4.1
Message-ID: <1612786.HeTW0LsLmg@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

I've collected some fixes which might be appropriate for 4.1-rc,
so if they're ok, please pull.

Thanks
Heiko


The following changes since commit a0307d186f5015ee3d77e209e5c06190cbf02478:

  ARM: rockchip: disable watchdog during suspend (2015-03-11 22:41:02 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.1-rockchip-socfixes1

for you to fetch changes up to 2a9fe3ca84afff6259820c4f62e579f41476becc:

  rockchip: make sure timer7 is enabled on rk3288 platforms (2015-04-16 21:22:17 +0200)

----------------------------------------------------------------
Two fixes from Chris Zhong, fixing some suspend oddities.
And I've given up on the timer7 issue. While I initially thought
devices would either have both the grave mmu issue requiring a uboot
update and the timer7 issue or none, it looks like in all units in the
field the mmu issue got fixed while the timer7 issue stayed on.
So instead of making everybody wanting to use mainline jump through a
hoop just make sure timer7 is on on boot before we init the arch-timer.

----------------------------------------------------------------
Chris Zhong (2):
      ARM: rockchip: disable dapswjdp during suspend
      ARM: rockchip: fix undefined instruction of reset_ctrl_regs

Heiko Stuebner (1):
      rockchip: make sure timer7 is enabled on rk3288 platforms

 arch/arm/mach-rockchip/pm.c       | 33 +++++++++++++++++++++++++++++++++
 arch/arm/mach-rockchip/pm.h       |  8 ++++++++
 arch/arm/mach-rockchip/rockchip.c | 19 +++++++++++++++++++
 3 files changed, 60 insertions(+)
