From: rvaswani@codeaurora.org (Rohit Vaswani)
Date: Thu,  1 Aug 2013 19:15:21 -0700
Subject: [RESEND PATCH 0/4]Add SMP support for MSM8660, MSM8960 and MSM8974
Message-ID: <1375409725-22004-1-git-send-email-rvaswani@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series re-organizes the platsmp.c and adds SMP support for
MSM8660, MSM8960 and MSM8974. This is based on 3.11-rc3.
We convert to using the cpus property in device tree and
add a "enable-method" property for arm32.
This helps select the appropriate release sequence for the
secondary cores based on the cpu.

Rohit Vaswani (4):
  ARM: msm: Remove pen_release usage
  ARM: msm: Re-organize platsmp to make it extensible
  ARM: msm: Add SMP support for 8960
  ARM: msm: Add support for 8974 SMP

 Documentation/devicetree/bindings/arm/cpus.txt     |   9 +
 Documentation/devicetree/bindings/arm/msm/kpss.txt |  16 ++
 Documentation/devicetree/bindings/arm/msm/scss.txt |  15 ++
 arch/arm/boot/dts/msm8660-surf.dts                 |  23 +-
 arch/arm/boot/dts/msm8960-cdp.dts                  |  22 ++
 arch/arm/boot/dts/msm8974.dts                      |  23 ++
 arch/arm/mach-msm/Makefile                         |   2 +-
 arch/arm/mach-msm/board-dt-8974.c                  |   3 +
 arch/arm/mach-msm/headsmp.S                        |  39 ---
 arch/arm/mach-msm/hotplug.c                        |  31 +--
 arch/arm/mach-msm/platsmp.c                        | 263 ++++++++++++++++-----
 arch/arm/mach-msm/scm-boot.h                       |   8 +-
 12 files changed, 330 insertions(+), 124 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/msm/kpss.txt
 create mode 100644 Documentation/devicetree/bindings/arm/msm/scss.txt
 delete mode 100644 arch/arm/mach-msm/headsmp.S

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
