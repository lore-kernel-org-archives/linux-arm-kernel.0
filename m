From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 14 May 2010 08:18:51 +0200
Subject: [PATCH v2] ARM: Samsung: S5PC100 platform cleanup
Message-ID: <1273817946-29404-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series perform a general cleanup in Samsung S5PC100 SoC support.
This chip is moved from custom s5pc1xx platform framework to new plat-s5p
framework, so more common code can be easily reused in upcomming extensions
for S5PV210/S5PC110 SoCs.

This patch series is prepared against next-samsung tree, with assumption
that the "[PATCH v3] ARM: S5PC100: Pre-requisite clock patch for plat-s5pc1xx
to plat-s5p" has been applied.

I've tried to split my changes as much as possible to clearly show how the
transition from plat-s5pc1xx to plat-s5p is being done.

Changes since v1:
- bases on completely new clock code provided by Kukjin Kim
- added some plat-s5p fixes required for transition
- removed custom functions from gpiolib implementation (now uses common
  code from plat-samsung)
- restructured the changes to avoid breaking the functionality beteen the
  patches
- some other minor cleanups (mainly c1xx to c100 renames)

This patch series includes:

[PATCH 01/15] ARM: Samsung: fix broken timer irq base
[PATCH 02/15] ARM: Samsung: move common I2C0 device helpers to machine directories
[PATCH 03/15] ARM: Samsung: move driver strength gpio configuration helper to common dir
[PATCH 04/15] drivers: serial: S5PC100 serial driver cleanup
[PATCH 05/15] ARM: S5PC100: Use common functions for gpiolib implementation
[PATCH 06/15] ARM: S5PC100: Move gpio support from plat-s5pc1xx to mach-s5pc100
[PATCH 07/15] ARM: S5PC100: rename gpio registers from s5pc1xx to s5pc100
[PATCH 08/15] ARM: S5PC100: Move frame buffer helpers from plat-s5pc1xx to mach-s5pc100
[PATCH 09/15] ARM: S5PC100: Move i2c helpers from plat-s5pc1xx to mach-s5pc100
[PATCH 10/15] ARM: S5PC100: Move sdhci helpers from plat-s5pc1xx to mach-s5pc100
[PATCH 11/15] ARM: Samsung: move S5PC100 support from plat-s5pc1xx to plat-s5p framework
[PATCH 12/15] ARM: SMDKC100: fix frame buffer definitions
[PATCH 13/15] ARM: Samsung: Move external interrupts support from plat-s5pc1xx to plat-s5p
[PATCH 14/15] ARM: S5PC100: Add support for gpio interrupt
[PATCH 15/15] ARM: remove obsolete plat-s5pc1xx directory
