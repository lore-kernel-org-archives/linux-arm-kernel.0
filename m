From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 17 Jul 2015 00:35:47 +0200
Subject: [GIT PULL 1/2] Rockchip soc changes for 4.3, part1
In-Reply-To: <2820374.NgluYWXZkW@diego>
References: <2820374.NgluYWXZkW@diego>
Message-ID: <8030973.PEt4S6scyC@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.3-rockchip32-soc1

for you to fetch changes up to cb8cc37f4d38d96552f2c52deb15e511cdacf906:

  ARM: rockchip: fix broken build (2015-07-06 11:46:08 +0200)

----------------------------------------------------------------
Some suspend improvements enabling the possibility to wakeup
from usbphy events and a rework of how cpu cores are brought
u? and down, as it was possible to produce lockups when
hammering the cpu hotplug functions.

----------------------------------------------------------------
Caesar Wang (4):
      ARM: rockchip: fix the CPU soft reset
      ARM: rockchip: ensure CPU to enter WFI/WFE state
      ARM: rockchip: fix the SMP code style
      ARM: rockchip: fix broken build

Chris Zhong (2):
      ARM: rockchip: add support holding 24Mhz osc during suspend
      ARM: rockchip: remove some useless macro in pm.h

Doug Anderson (1):
      ARM: rockchip: restore dapswjdp after suspend

 arch/arm/mach-rockchip/platsmp.c | 56 ++++++++++++++++++++++++----------------
 arch/arm/mach-rockchip/pm.c      | 45 ++++++++++++++++++++++++++++++--
 arch/arm/mach-rockchip/pm.h      |  7 -----
 3 files changed, 77 insertions(+), 31 deletions(-)
