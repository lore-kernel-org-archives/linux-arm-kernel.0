From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Mon, 16 Jan 2012 15:52:39 +0530
Subject: [PATCH 4/5] ARM : OMAP : serial : Make context_loss_cnt signed
In-Reply-To: <1326709360-26020-1-git-send-email-shubhrajyoti@ti.com>
References: <1326709360-26020-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <1326709360-26020-5-git-send-email-shubhrajyoti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

get_context_loss_count returns an int however it is stored in
unsigned integer context_loss_cnt . This patch tries to make
context_loss_cnt int. So that in case of errors(which may be negative)
the value is not interpreted wrongly.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 arch/arm/plat-omap/include/plat/omap-serial.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
index 9ff4444..b7fb6dc 100644
--- a/arch/arm/plat-omap/include/plat/omap-serial.h
+++ b/arch/arm/plat-omap/include/plat/omap-serial.h
@@ -128,7 +128,7 @@ struct uart_omap_port {
 	unsigned char		msr_saved_flags;
 	char			name[20];
 	unsigned long		port_activity;
-	u32			context_loss_cnt;
+	int			context_loss_cnt;
 	u32			errata;
 	u8			wakeups_enabled;
 
-- 
1.7.1
