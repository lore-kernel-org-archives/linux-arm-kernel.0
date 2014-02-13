From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 13 Feb 2014 17:25:58 +0900
Subject: [PATCH 00/03] ARM: shmobile: Clean up the EMEV2 and KZM9D code base
Message-ID: <20140213082558.30630.93034.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: shmobile: Clean up the EMEV2 and KZM9D code base

[PATCH 01/03] ARM: shmobile: Remove legacy EMEV2 SoC support
[PATCH 02/03] ARM: shmobile: Remove KZM9D board code
[PATCH 03/03] ARM: shmobile: Get rid of legacy KZM9D defconfig

These patches clean up the EMEV2 SoC and the KZM9D board support code.

With these patches applied:
 - EMEV2 is enabled for the MULTIPLATFORM case only, making use of CCF
 - KZM9D is implemented as DT code only, no C code exists
 - The legacy EMEV2 code is gone, so is the legacy clock framework code
 - The legacy defconfig is gone, making way for a shared multiplatform defconfig

This means that KZM9D support comes without a Kconfig entry. Also,
the load address for u-boot needs to be supplied by hand (0x40008000).

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas.git tag renesas-devel-v3.14-rc1-20140207

 arch/arm/boot/dts/Makefile                     |    3 
 arch/arm/configs/kzm9d_defconfig               |   91 ---------
 arch/arm/mach-shmobile/Kconfig                 |   15 -
 arch/arm/mach-shmobile/Makefile                |    2 
 arch/arm/mach-shmobile/board-kzm9d-reference.c |   47 ----
 arch/arm/mach-shmobile/clock-emev2.c           |  231 ------------------------
 arch/arm/mach-shmobile/include/mach/emev2.h    |    9 
 arch/arm/mach-shmobile/setup-emev2.c           |    7 
 arch/arm/mach-shmobile/smp-emev2.c             |    1 
 9 files changed, 3 insertions(+), 403 deletions(-)
