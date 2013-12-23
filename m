From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 23 Dec 2013 09:48:08 +0100
Subject: [PATCH 0/3] ARM: mvebu: minor improvements
Message-ID: <1387788491-3168-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason, Gregory, Sebastian, Andrew,

Here are three patches making minor improvements to the mvebu code
base.

 * The first one moves an 370/XP specific declaration to
   armada-370-xp.h, in preparation for the future addition of the
   support for other SOCs in mach-mvebu/. It should go to mvebu/soc.

 * The second one fixes the length of the registers of the Armada XP
   PMSU. It should go to mvebu/dt. There is no need to push this as a
   fix, as it *reduces* the length of the register area, so it is
   really only a cosmetic improvement.

 * The third one makes a function static. It should to to mvebu/soc.

Thanks!

Thomas

Thomas Petazzoni (3):
  ARM: mvebu: move ARMADA_XP_MAX_CPUS to armada-370-xp.h
  ARM: mvebu: fix register length for Armada XP PMSU
  ARM: mvebu: make armada_370_xp_pmsu_init() static

 arch/arm/boot/dts/armada-xp.dtsi    | 2 +-
 arch/arm/mach-mvebu/armada-370-xp.h | 2 ++
 arch/arm/mach-mvebu/common.h        | 3 ---
 arch/arm/mach-mvebu/pmsu.c          | 2 +-
 4 files changed, 4 insertions(+), 5 deletions(-)

-- 
1.8.3.2
