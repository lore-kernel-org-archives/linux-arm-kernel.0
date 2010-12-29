From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Wed, 29 Dec 2010 21:33:48 +0100
Subject: [PATCH 2/2] arm/pxa: buildfix for pam27x without fb
In-Reply-To: <1293654828-24661-1-git-send-email-bigeasy@linutronix.de>
References: <1293654828-24661-1-git-send-email-bigeasy@linutronix.de>
Message-ID: <1293654828-24661-2-git-send-email-bigeasy@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

|arch/arm/mach-pxa/palmld.c: In function ?palmld_init?:
|arch/arm/mach-pxa/palmld.c:330: error: ?palm_320x480_lcd_mode? undeclared (first use in this function)
|arch/arm/mach-pxa/palmld.c:330: error: (Each undeclared identifier is reported only once
|arch/arm/mach-pxa/palmld.c:330: error: for each function it appears in.)

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/mach-pxa/include/mach/palm27x.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/palm27x.h b/arch/arm/mach-pxa/include/mach/palm27x.h
index 0a5e5ea..7b7927c 100644
--- a/arch/arm/mach-pxa/include/mach/palm27x.h
+++ b/arch/arm/mach-pxa/include/mach/palm27x.h
@@ -34,7 +34,7 @@ extern struct pxafb_mode_info palm_320x320_new_lcd_mode;
 extern void __init palm27x_lcd_init(int power,
 					struct pxafb_mode_info *mode);
 #else
-static inline void palm27x_lcd_init(int power, struct pxafb_mode_info *mode) {}
+#define palm27x_lcd_init(power, mode)	do { } while (0)
 #endif
 
 #if	defined(CONFIG_USB_GADGET_PXA27X) || \
-- 
1.7.3.2
