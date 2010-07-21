From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 21 Jul 2010 17:57:44 +0900
Subject: [PATCH 1/3] ARM: SAMSUNG: Updates RTC register for support Alarm IRQ
	and Time Tick.
In-Reply-To: <1279702666-13021-1-git-send-email-kgene.kim@samsung.com>
References: <1279702666-13021-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1279702666-13021-2-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Atul Dahiya <atul.dahiya@samsung.com>

This patch updates RTC registers for support Alarm IRQ and Time Tick.

Signed-off-by: Atul Dahiya <atul.dahiya@samsung.com>
Signed-off-by: Taekgyun Ko <taeggyun.ko@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/plat-samsung/include/plat/regs-rtc.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/regs-rtc.h b/arch/arm/plat-samsung/include/plat/regs-rtc.h
index 65c190d..30b7cc1 100644
--- a/arch/arm/plat-samsung/include/plat/regs-rtc.h
+++ b/arch/arm/plat-samsung/include/plat/regs-rtc.h
@@ -14,6 +14,9 @@
 #define __ASM_ARCH_REGS_RTC_H __FILE__
 
 #define S3C2410_RTCREG(x) (x)
+#define S3C2410_INTP		S3C2410_RTCREG(0x30)
+#define S3C2410_INTP_ALM	(1 << 1)
+#define S3C2410_INTP_TIC	(1 << 0)
 
 #define S3C2410_RTCCON	      S3C2410_RTCREG(0x40)
 #define S3C2410_RTCCON_RTCEN  (1<<0)
-- 
1.6.2.5
