From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri,  6 Jan 2012 10:41:50 +0800
Subject: [PATCH 0/2] ARM: mxs: use CHIPID hardware to detect SoC
Message-ID: <1325817712-4573-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As suggested by Wolfram, the first patch changes cpu_is_xxx and
__arch_decomp_setup to use the CHIPID register than machine type to
detect the chip between imx23 and imx28, so that we do not need to
change these functions whenever a new board/machine gets added.

The second one is a rebase of patch [1] on above patch.

Regards,
Shawn

[1] [PATCH v4] ARM: mxs: Add initial support for Bluegiga APX4 Development Kit

---

Lauri Hintsala (1):
      ARM: mxs: Add initial support for Bluegiga APX4 Development Kit

Shawn Guo (1):
      ARM: mxs: detect SoC by checking CHIPID register

 arch/arm/mach-mxs/Kconfig                   |   16 ++
 arch/arm/mach-mxs/Makefile                  |    1 +
 arch/arm/mach-mxs/include/mach/mxs.h        |   28 ++--
 arch/arm/mach-mxs/include/mach/uncompress.h |   11 +-
 arch/arm/mach-mxs/mach-apx4devkit.c         |  245 +++++++++++++++++++++++++++
 5 files changed, 283 insertions(+), 18 deletions(-)
