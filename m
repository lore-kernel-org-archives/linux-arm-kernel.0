From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 23 Aug 2013 13:23:00 +0100
Subject: [PATCH 0/40] ARM: ux500: Convert to Device Tree only platform
Message-ID: <1377260620-18829-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I started by taking out simple, unimportant pieces, then finalised by
removing the critical booting components required for booting with
ATAGs. After this patch-set the ux500 will only boot with Device Tree
enabled. DT boot appears to be unaffected by the work, tested on
Snowball.

 arch/arm/mach-ux500/Makefile                |   4 +-
 arch/arm/mach-ux500/board-mop500-audio.c    |  50 ----------
 arch/arm/mach-ux500/board-mop500-sdi.c      |  51 ----------
 arch/arm/mach-ux500/board-mop500-stuib.c    | 120 -----------------------
 arch/arm/mach-ux500/board-mop500-u8500uib.c |  92 ------------------
 arch/arm/mach-ux500/board-mop500-uib.c      | 133 -------------------------
 arch/arm/mach-ux500/board-mop500.c          | 640 ------------------------------------------------------------------------------------------------------------------------
 arch/arm/mach-ux500/board-mop500.h          |  16 ---
 arch/arm/mach-ux500/cpu-db8500.c            |  78 ---------------
 arch/arm/mach-ux500/cpu.c                   |   5 -
 arch/arm/mach-ux500/devices-common.c        |  60 ------------
 arch/arm/mach-ux500/devices-common.h        | 134 -------------------------
 arch/arm/mach-ux500/devices-db8500.c        |  93 ------------------
 arch/arm/mach-ux500/devices-db8500.h        | 109 ---------------------
 arch/arm/mach-ux500/devices.h               |   8 --
 arch/arm/mach-ux500/setup.h                 |   1 -
 arch/arm/mach-ux500/usb.c                   | 135 --------------------------
 17 files changed, 1 insertion(+), 1728 deletions(-)
