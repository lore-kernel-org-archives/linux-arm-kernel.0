From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu,  7 Jul 2011 12:18:39 +0200
Subject: [PATCH 4/4] arm: mach-s3c2440: mini2440: fix section mismatch
In-Reply-To: <1310033919-4245-1-git-send-email-w.sang@pengutronix.de>
References: <1310033919-4245-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <1310033919-4245-5-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If mini2440_init() is in __init, mini2440_parse_features() should also
be in __init. Fixes:

(.text+0x9adc): Section mismatch in reference from the function mini2440_parse_features.clone.0() to the (unknown reference) .init.data:(unknown)
The function mini2440_parse_features.clone.0() references the (unknown reference) __initdata (unknown).

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Michel Pollet <buserror@gmail.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c2440/mach-mini2440.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c2440/mach-mini2440.c b/arch/arm/mach-s3c2440/mach-mini2440.c
index dd3120d..fc2dc0b 100644
--- a/arch/arm/mach-s3c2440/mach-mini2440.c
+++ b/arch/arm/mach-s3c2440/mach-mini2440.c
@@ -552,7 +552,7 @@ struct mini2440_features_t {
 	struct platform_device *optional[8];
 };
 
-static void mini2440_parse_features(
+static void __init mini2440_parse_features(
 		struct mini2440_features_t * features,
 		const char * features_str )
 {
-- 
1.7.5.4
