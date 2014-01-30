From: galak@codeaurora.org (Kumar Gala)
Date: Thu, 30 Jan 2014 12:36:38 -0600
Subject: [PATCH 0/4] Split mach-msm into legacy and mach-qcom (multiplatform)
Message-ID: <1391107002-21470-1-git-send-email-galak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the starts of splitting the Qualcomm MSM platform into legacy support
that we will not try and convert to multiplatform and multiplatform support.
These patches are based on the 'CPU enable method based SMP' patches.

I wanted to get these out for review, will add a few more patches for defconfig
updates/additions, as well as some additional driver being enabled for ARCH_QCOM.

- k

 arch/arm/mach-msm/board-dt.c       |   27 --
 arch/arm/mach-msm/hotplug.c        |   51 ----
 arch/arm/mach-msm/platsmp.c        |  371 ------------------------------------
 arch/arm/mach-msm/scm-boot.c       |   39 ---
 arch/arm/mach-msm/scm-boot.h       |   24 --
 arch/arm/mach-msm/scm.c            |  299 -----------------------------
 arch/arm/mach-msm/scm.h            |   25 --
 arch/arm/mach-msm/timer.c          |  333 --------------------------------
 b/MAINTAINERS                      |    7 
 b/arch/arm/Kconfig                 |    7 
 b/arch/arm/Makefile                |    1 
 b/arch/arm/boot/dts/Makefile       |    6 
 b/arch/arm/mach-msm/Kconfig        |   54 -----
 b/arch/arm/mach-msm/Makefile       |    8 
 b/arch/arm/mach-qcom/Kconfig       |   34 +++
 b/arch/arm/mach-qcom/Makefile      |    5 
 b/arch/arm/mach-qcom/board.c       |   26 ++
 b/arch/arm/mach-qcom/scm-boot.c    |   39 +++
 b/arch/arm/mach-qcom/scm-boot.h    |   24 ++
 b/arch/arm/mach-qcom/scm.c         |  299 +++++++++++++++++++++++++++++
 b/arch/arm/mach-qcom/scm.h         |   25 ++
 b/arch/arm/mach-qcom/smp.c         |  380 +++++++++++++++++++++++++++++++++++++
 b/drivers/clocksource/Kconfig      |    4 
 b/drivers/clocksource/Makefile     |    1 
 b/drivers/clocksource/qcom-timer.c |  330 ++++++++++++++++++++++++++++++++
 b/drivers/tty/serial/Kconfig       |    2 
 26 files changed, 1188 insertions(+), 1233 deletions(-)
