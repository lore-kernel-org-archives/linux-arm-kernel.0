From: mylene.josserand@free-electrons.com (=?UTF-8?q?Myl=C3=A8ne=20Josserand?=)
Date: Mon, 11 Dec 2017 08:49:57 +0100
Subject: [PATCH 0/4] Sunxi: Add SMP support on A83T
Message-ID: <20171211075001.6100-1-mylene.josserand@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello everyone,

This series adds SMP support for Allwinner Sun8i-a83t
with MCPM (Multi-Cluster Power Management).
Series information:
	- Based on last linux-next (next-20171211)
	- Had dependencies on Chen Yu's patch that add MCPM
	support:
	https://patchwork.kernel.org/patch/6402801/

Patch 01: Convert the mcpm driver (initially for A80) to be able
to use it for A83T. This SoC has a bit flip that needs to be handled.
Patch 02: Add registers nodes (prcm, cpucfg and r_cpucfg) needed
for MCPM.
Patch 03: Add CCI-400 node for a83t.
Patch 04: Fix the use of virtual timers that hangs the kernel in
case of SMP support.

If you have any remarks/questions, let me know.
Thank you in advance,
Myl?ne

Myl?ne Josserand (4):
  ARM: sunxi: mcpm: Add support for A83T
  arm: dts: sun8i: a83t: Add registers needed for MCPM
  arm: dts: sun8i: a83t: Add CCI-400 node
  arm: dts: sun8i: a83t: Set timer node to use phy timer

 arch/arm/boot/dts/sun8i-a83t.dtsi | 57 +++++++++++++++++++++++++
 arch/arm/mach-sunxi/Kconfig       |  1 +
 arch/arm/mach-sunxi/mcpm.c        | 90 ++++++++++++++++++++++++++++++++++++---
 3 files changed, 143 insertions(+), 5 deletions(-)

-- 
2.11.0
