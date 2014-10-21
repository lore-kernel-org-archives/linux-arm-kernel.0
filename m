From: johan@kernel.org (Johan Hovold)
Date: Tue, 21 Oct 2014 19:38:00 +0200
Subject: [PATCH v2 14/20] rtc: omap: add helper to read 32-bit registers
In-Reply-To: <1413913086-12730-1-git-send-email-johan@kernel.org>
References: <1412881594-25678-1-git-send-email-johan@kernel.org>
 <1413913086-12730-1-git-send-email-johan@kernel.org>
Message-ID: <1413913086-12730-15-git-send-email-johan@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add helper to read full register width.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/rtc/rtc-omap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index bcdf3c596214..c508e45ca3ce 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -123,6 +123,11 @@ static inline u8 rtc_read(struct omap_rtc *rtc, unsigned int reg)
 	return readb(rtc->base + reg);
 }
 
+static inline u32 rtc_readl(struct omap_rtc *rtc, unsigned int reg)
+{
+	return readl(rtc->base + reg);
+}
+
 static inline void rtc_write(struct omap_rtc *rtc, unsigned int reg, u8 val)
 {
 	writeb(val, rtc->base + reg);
-- 
2.0.4
