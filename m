From: oss@buserror.net (Scott Wood)
Date: Sun, 10 Apr 2016 21:22:31 -0500
Subject: [RFC PATCH 0/2] ARM/ARM64: arch_timer: QorIQ errata
Message-ID: <1460341353-15619-1-git-send-email-oss@buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches work around timer errata on certain Freescale QorIQ ARM
chips.

Please let me know if there's a particular way these patches should be
split up, or any other feedback.

Priyanka Jain (1):
  ARM64: arch_timer: Work around QorIQ Erratum A-009971

Scott Wood (1):
  ARM/ARM64: arch_timer: Work around QorIQ Erratum A-008585

 .../devicetree/bindings/arm/arch_timer.txt         |  9 +++
 arch/arm/boot/dts/ls1021a.dtsi                     |  1 +
 arch/arm/include/asm/arch_timer.h                  | 71 +++++++++++++++++++---
 arch/arm/include/asm/vdso_datapage.h               |  1 +
 arch/arm/kernel/vdso.c                             |  1 +
 arch/arm/vdso/vgettimeofday.c                      |  2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     |  1 +
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi     |  2 +
 arch/arm64/include/asm/arch_timer.h                | 62 ++++++++++++++++---
 arch/arm64/include/asm/vdso_datapage.h             |  1 +
 arch/arm64/kernel/asm-offsets.c                    |  1 +
 arch/arm64/kernel/vdso.c                           |  2 +
 arch/arm64/kernel/vdso/gettimeofday.S              | 14 ++++-
 drivers/clocksource/arm_arch_timer.c               |  8 +++
 14 files changed, 155 insertions(+), 21 deletions(-)

-- 
2.5.0
