From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Sun, 25 Oct 2009 00:04:02 +0400
Subject: [PATCH 04/20] SA1100: h3600: remove unused cruft from h3600.h
In-Reply-To: <1256414658-22611-4-git-send-email-mad_soft@inbox.ru>
References: <1256414658-22611-1-git-send-email-mad_soft@inbox.ru>
	<1256414658-22611-2-git-send-email-mad_soft@inbox.ru>
	<1256414658-22611-3-git-send-email-mad_soft@inbox.ru>
	<1256414658-22611-4-git-send-email-mad_soft@inbox.ru>
Message-ID: <1256414658-22611-5-git-send-email-mad_soft@inbox.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PM_SUSPEND, PM_RESUME and machine_is_h3xxx() are not used anywhere in
kernel (checked with git grep), so it's safe to remove them.

Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
---
 arch/arm/mach-sa1100/include/mach/h3600.h |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-sa1100/include/mach/h3600.h b/arch/arm/mach-sa1100/include/mach/h3600.h
index 2827faa..69f138c 100644
--- a/arch/arm/mach-sa1100/include/mach/h3600.h
+++ b/arch/arm/mach-sa1100/include/mach/h3600.h
@@ -23,14 +23,6 @@
 #ifndef _INCLUDE_H3600_H_
 #define _INCLUDE_H3600_H_
 
-typedef int __bitwise pm_request_t;
-
-#define PM_SUSPEND	((__force pm_request_t) 1)	/* enter D1-D3 */
-#define PM_RESUME	((__force pm_request_t) 2)	/* enter D0 */
-
-/* generalized support for H3xxx series Compaq Pocket PC's */
-#define machine_is_h3xxx() (machine_is_h3100() || machine_is_h3600())
-
 /* Physical memory regions corresponding to chip selects */
 #define H3600_EGPIO_PHYS	(SA1100_CS5_PHYS + 0x01000000)
 #define H3600_BANK_2_PHYS	SA1100_CS2_PHYS
-- 
1.6.5.1.63.ga9d7.dirty
