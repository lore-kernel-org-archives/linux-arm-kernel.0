From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 27 Sep 2010 15:50:39 +0200
Subject: [PATCH 03/40] ARM: mx5/mx51_babbage: fix compiler warnings
In-Reply-To: <20100927135009.GC6271@pengutronix.de>
References: <20100927135009.GC6271@pengutronix.de>
Message-ID: <1285595476-10025-3-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx5/board-mx51_babbage.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index 10d2f6b..3ef1214 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -218,7 +218,7 @@ static int initialize_otg_port(struct platform_device *pdev)
 {
 	u32 v;
 	void __iomem *usb_base;
-	u32 usbother_base;
+	void __iomem *usbother_base;
 
 	usb_base = ioremap(MX51_OTG_BASE_ADDR, SZ_4K);
 	usbother_base = usb_base + MX5_USBOTHER_REGS_OFFSET;
@@ -236,7 +236,7 @@ static int initialize_usbh1_port(struct platform_device *pdev)
 {
 	u32 v;
 	void __iomem *usb_base;
-	u32 usbother_base;
+	void __iomem *usbother_base;
 
 	usb_base = ioremap(MX51_OTG_BASE_ADDR, SZ_4K);
 	usbother_base = usb_base + MX5_USBOTHER_REGS_OFFSET;
-- 
1.7.2.3
