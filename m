From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 24 Feb 2014 16:29:21 +0900
Subject: [PATCH 00/03] ARM: shmobile: Break out and extend clock workaround
Message-ID: <20140224072921.3522.55023.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: shmobile: Break out and extend clock workaround

[PATCH 01/03] ARM: shmobile: Introduce shmobile_clk_workaround()
[PATCH 02/03] ARM: shmobile: Use shmobile_clk_workaround() on Lager
[PATCH 03/03] ARM: shmobile: Use shmobile_clk_workaround() on Koelsch

These patches consolidates the clkdev workaround present in the DT
reference version of board code for Lager and Koelsch, and it also
extends it to allow static enablement of a selected set of clocks
during boot. The latter is needed for USB PCI support patches that
will be posted shortly.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas.git tag renesas-devel-v3.14-rc3-20140224
 on top of "[PATCH 00/12] ARM: shmobile: Rework include path for SoC files"

 arch/arm/mach-shmobile/Makefile                  |    2 
 arch/arm/mach-shmobile/board-koelsch-reference.c |   71 ++++++++--------------
 arch/arm/mach-shmobile/board-lager-reference.c   |   65 +++++++-------------
 arch/arm/mach-shmobile/clock.c                   |   29 ++++++++
 arch/arm/mach-shmobile/include/mach/clock.h      |   16 ++++
 5 files changed, 99 insertions(+), 84 deletions(-)
