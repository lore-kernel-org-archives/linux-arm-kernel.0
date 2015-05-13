From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 13 May 2015 16:17:24 +0200
Subject: [GIT PULL] ARM: rockchip: fixup duplicate suspend fix
Message-ID: <4262241.MKs4C65R3h@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

it looks like I got confused when going through the patches fixing suspend
issues and from the two of them only one is actually necessary, as both fix
the same symptom. Thankfully Chris pointed out this issue and also
confirmed which patch should actually be kept. So this pull-req reverts the
other (obsolete) one.

Sorry for the mess-up.

Heiko


The following changes since commit 2a9fe3ca84afff6259820c4f62e579f41476becc:

  rockchip: make sure timer7 is enabled on rk3288 platforms (2015-04-16 21:22:17 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.1-rockchip-socfixes2

for you to fetch changes up to 3f937cf3db466093c533efbcd601952509727a9d:

  Revert "ARM: rockchip: fix undefined instruction of reset_ctrl_regs" (2015-05-13 15:47:03 +0200)

----------------------------------------------------------------
The previous two suspend related fixes both fix the same issue
so only one of them (the newer one) is actually needed.

----------------------------------------------------------------
Heiko Stuebner (1):
      Revert "ARM: rockchip: fix undefined instruction of reset_ctrl_regs"

 arch/arm/mach-rockchip/pm.c | 26 --------------------------
 arch/arm/mach-rockchip/pm.h |  4 ----
 2 files changed, 30 deletions(-)
