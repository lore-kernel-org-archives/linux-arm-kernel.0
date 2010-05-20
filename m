From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 20 May 2010 07:51:07 +0200
Subject: [PATCH v4] ARM: Samsung: plat-s5pc1xx cleanup
Message-ID: <1274334671-21838-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series perform a general cleanup in Samsung S5PC100 SoC support.
This chip is moved from custom s5pc1xx platform framework to new plat-s5p
framework, so more common code can be easily reused in upcomming extensions
for S5PV210/S5PC110 SoCs.

This patch series is prepared against for-linus/samsung4 tree, with
assumption that the "[PATCH v6] ARM: S5P: Add Ext interrupt support" and
"ARM: S5PC100: Move sdhci helpers from plat-s5pc1xx to mach-s5pc100"
patches has been previously applied.

I've tried to split my changes as much as possible to clearly show how the
transition from plat-s5pc1xx to plat-s5p is being done.

Changes since v3:
- use common external interrupt code from plat-s5p
- rebased onto git://git.fluff.org/bjdooks/linux for-linus/samsung4

Changes since v2:
- fixed some whitespace/tabs errors
- removed external interrupt code, a common code from plat-s5p will be used
- moved SMDKC100 fixes to separate patch series

Changes since v1:
- bases on completely new clock code provided by Kukjin Kim
- added some plat-s5p fixes required for transition
- removed custom functions from gpiolib implementation (now uses common
  code from plat-samsung)
- restructured the changes to avoid breaking the functionality beteen the
  patches
- some other minor cleanups (mainly c1xx to c100 renames)

This patch series includes:

[PATCH 1/4] ARM: Samsung: move S5PC100 support from plat-s5pc1xx to plat-s5p framework
[PATCH 2/4] ARM: S5PC100: Add support for gpio interrupt
[PATCH 3/4] ARM: S5PC100: use common plat-s5p external interrupt code
[PATCH 4/4] ARM: remove obsolete plat-s5pc1xx directory

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
