From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 13 Mar 2014 08:36:08 +0900
Subject: [PATCH v2 00/03] ARM: shmobile: Break out and extend clock workaround
 V2
Message-ID: <20140312233608.17009.65690.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: shmobile: Break out and extend clock workaround V2

[PATCH v2 01/03] ARM: shmobile: Introduce shmobile_clk_workaround()
[PATCH 02/03] ARM: shmobile: Use shmobile_clk_workaround() on Lager
[PATCH 03/03] ARM: shmobile: Use shmobile_clk_workaround() on Koelsch

These patches consolidates the clkdev workaround present in the DT
reference version of board code for Lager and Koelsch, and it also
extends it to allow static enablement of a selected set of clocks
during boot. The latter is needed for USB PCI support patches that
have been posted.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Changes since V1:
 - Reworked dependencies, updated header file path in patch [1/3].

 Written against renesas.git tag renesas-devel-v3.14-rc6-20140311

 arch/arm/mach-shmobile/Makefile                  |    2 
 arch/arm/mach-shmobile/board-koelsch-reference.c |   71 ++++++++--------------
 arch/arm/mach-shmobile/board-lager-reference.c   |   65 +++++++-------------
 arch/arm/mach-shmobile/clock.c                   |   29 ++++++++
 arch/arm/mach-shmobile/include/mach/clock.h      |   16 ++++
 5 files changed, 99 insertions(+), 84 deletions(-)
