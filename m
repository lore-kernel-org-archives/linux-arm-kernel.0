From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 11 Jun 2013 18:48:03 -0700
Subject: [PATCH 0/3] Remove msm_iomap for 8x60 and 8960
Message-ID: <1371001686-15985-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset moves the MSM code over to DEBUG_LL_INCLUDE
as well as removes the rest of the static mappings made on
8x60 and 8960. This allows us to remove the msm_iomap-8x60.h
msm_iomap-8960.h. Note that debug_ll_io_init() will
be the default in 3.11 so we'll have to make a sweep in the merge
window or after to remove those two.

Patches are based on David Brown's MSM for-next tree.

git://git.kernel.org/pub/scm/linux/kernel/git/davidb/linux-msm.git for-next

Stephen Boyd (3):
  ARM: msm: Move debug-macro.S to include/debug
  ARM: msm: Remove TMR and TMR0 static mappings
  ARM: msm: Don't compile __msm_ioremap_caller() unless used

 arch/arm/Kconfig.debug                             |  9 +++-
 .../mach/debug-macro.S => include/debug/msm.S}     | 32 ++++++++++-
 arch/arm/mach-msm/board-dt-8660.c                  |  3 +-
 arch/arm/mach-msm/board-dt-8960.c                  |  3 +-
 arch/arm/mach-msm/common.h                         |  2 -
 arch/arm/mach-msm/include/mach/msm_iomap-7x00.h    |  9 ----
 arch/arm/mach-msm/include/mach/msm_iomap-7x30.h    |  9 ----
 arch/arm/mach-msm/include/mach/msm_iomap-8960.h    | 46 ----------------
 arch/arm/mach-msm/include/mach/msm_iomap-8x50.h    |  9 ----
 arch/arm/mach-msm/include/mach/msm_iomap-8x60.h    | 49 -----------------
 arch/arm/mach-msm/include/mach/msm_iomap.h         | 17 ------
 arch/arm/mach-msm/include/mach/uncompress.h        | 63 ----------------------
 arch/arm/mach-msm/io.c                             | 47 ++--------------
 13 files changed, 46 insertions(+), 252 deletions(-)
 rename arch/arm/{mach-msm/include/mach/debug-macro.S => include/debug/msm.S} (61%)
 delete mode 100644 arch/arm/mach-msm/include/mach/msm_iomap-8960.h
 delete mode 100644 arch/arm/mach-msm/include/mach/msm_iomap-8x60.h
 delete mode 100644 arch/arm/mach-msm/include/mach/uncompress.h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
