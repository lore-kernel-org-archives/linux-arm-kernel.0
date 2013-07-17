From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 18 Jul 2013 05:30:49 +0900
Subject: [PATCH v2 00/04] ARM: shmobile: ARCH_MULTIPLATFORM for EMEV2 and KZM9D
Message-ID: <20130717203049.27542.78385.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: shmobile: ARCH_MULTIPLATFORM for EMEV2 and KZM9D (v2)

[PATCH v2 01/04] ARM: shmobile: Only build clocks when COMMON_CLK=n
[PATCH 02/04] ARM: shmobile: Introduce ARCH_SHMOBILE_MULTI
[PATCH v2 03/04] ARM: shmobile: Add EMEV2 and KZM9D to ARCH_SHMOBILE_MULTI
[PATCH 04/04] ARM: shmobile: Allow ARCH_SHMOBILE_MULTI timer configuration

This patch set extends mach-shmobile to allow a subset of SoCs and
boards to be built for ARCH_MULTIPLATFORM. With this v2 series applied
the EMEV2 SoC and the KZM9D board can be built in two ways - either
as good old ARCH_SHMOBILE or new ARCH_SHMOBILE_MULTI. The latter
requires common clock framework for proper run time operation.

The goal is to over time move all DT reference implementations from
ARCH_SHMOBILE to ARCH_SHMOBILE_MULTI. Until CCF is available for a
certain SoC it is to me acceptable for a DT reference board to allow
build in both ARCH_SHMOBILE and ARCH_SHMOBILE_MULTI. The reason for
this is to allow incremental development and easy testing during
development of CCF for a certain SoC. The KZM9D board is now in this
state while it is waiting for common clocks to become ready.

Until CCF is supported for EMEV2 the KZM9D board can be tested with
ARCH_SMOBILE_MULTI without clocks using the following prototype:
[PATCH] ARM: shmobile: MULTIPLATFORM KZM9D with no clocks prototype hack

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Built on top of renesas-devel-20130717

 arch/arm/Makefile                              |    1 
 arch/arm/boot/dts/Makefile                     |    1 
 arch/arm/mach-shmobile/Kconfig                 |   52 +++++++++++++++++++++---
 arch/arm/mach-shmobile/Makefile                |   33 +++++++++++----
 arch/arm/mach-shmobile/board-kzm9d-reference.c |    3 -
 arch/arm/mach-shmobile/setup-emev2.c           |    3 -
 6 files changed, 77 insertions(+), 16 deletions(-)
