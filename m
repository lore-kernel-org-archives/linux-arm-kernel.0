From: robherring2@gmail.com (Rob Herring)
Date: Mon,  9 Jan 2012 16:45:40 -0600
Subject: [PATCH 0/6] BSYM macro removal
Message-ID: <1326149146-19756-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

IIRC, BSYM usage is unnecessary in .c files according to Dave Martin. It
is not only unnecessary, but it generates the wrong address by adding 1
to already correct addresses in Thumb2 builds. So a Thumb2 SMP kernel
doesn't boot secondary cores. I thought I had previously tried this
combination out, so I'm not sure if something has changed here.

I've only tested on highbank, so testing is appreciated.

Rob Herring (6):
  ARM: exynos: remove incorrect BSYM usage
  ARM: realview: remove incorrect BSYM usage
  ARM: vexpress: remove incorrect BSYM usage
  ARM: imx: remove incorrect BSYM usage
  ARM: highbank: remove incorrect BSYM usage
  ARM: make BSYM macro assembly only

 arch/arm/include/asm/unified.h    |    4 ++--
 arch/arm/mach-exynos/platsmp.c    |    5 ++---
 arch/arm/mach-highbank/highbank.c |    3 +--
 arch/arm/mach-imx/src.c           |    3 +--
 arch/arm/mach-realview/platsmp.c  |    3 +--
 arch/arm/mach-vexpress/platsmp.c  |    4 +---
 6 files changed, 8 insertions(+), 14 deletions(-)

-- 
1.7.5.4
