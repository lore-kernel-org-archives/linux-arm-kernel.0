From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 02 Apr 2010 08:48:48 +0200
Subject: [PATCH] ARM: Samsung: S5PC100 platform cleanup
Message-ID: <1270190944-21644-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series perform a general cleanup in Samsung S5PC100 SoC support.
This chip is moved from custom s5pc1xx platform framework to new plat-s5p
framework, so more common code can be easily reused in upcomming extensions
for S5PV210/S5PC110 SoCs.

This patch series is prepared with assumption that my previous patch series
are already applied:
1. Add support for Aquita board (Samsung S5PC110 based)
2. ARM: Samsung: fix broken timer irq base
3. Add S5PV210/S5PC110 platform helpers

I've tried to split my changes as much as possible to clearly show how the
transition from plat-s5pc1xx to plat-s5p is being done.

This patch series includes:

[PATCH 01/16] ARM: S5PC1xx rename registers to match plat-s5p style
[PATCH 02/16] drivers: serial: S5PC100 serial driver cleanup
[PATCH 03/16] ARM: Samsung: plat-s5p - enable access to clk_27m clock
[PATCH 04/16] ARM: S5PC100: copy clocks from plat-s5pc1xx
[PATCH 05/16] ARM: S5PC100: new clocks definition
[PATCH 06/16] ARM: Samsung: move S5PC100 support from plat-s5pc1xx to plat-s5p framework
[PATCH 07/16] ARM: S5PC100: Move gpio support from plat-s5pc1xx to mach-s5pc100
[PATCH 08/16] ARM: S5PC100: Move frame buffer helpers from plat-s5pc1xx to mach-s5pc100
[PATCH 09/16] ARM: SMDKC100: enable frame buffer again
[PATCH 10/16] ARM: S5PC100: Move i2c helpers from plat-s5pc1xx to mach-s5pc100
[PATCH 11/16] ARM: SMDKC100: enable i2c support again
[PATCH 12/16] ARM: S5PC100: Move sdhci helpers from plat-s5pc1xx to mach-s5pc100
[PATCH 13/16] ARM: SMDKC100: enable sdhci support again
[PATCH 14/16] ARM: Samsung: Move external interrupts support from plat-s5pc1xx to plat-s5p
[PATCH 15/16] ARM: S5PC100: Add support for gpio interrupt
[PATCH 16/16] ARM: remove obsolete plat-s5pc1xx directory
