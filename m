From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 26 Apr 2010 23:23:48 +0200
Subject: [PATCH] vpac/pxa270: remove TS_IRQ magic number
Message-ID: <1272317028-3650-1-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The touchscreen GPIO IRQ was used as a magic number. Define it properly in the
board header file. This is a simple cleanup patch.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/include/mach/vpac270.h |    2 ++
 arch/arm/mach-pxa/vpac270.c              |    2 +-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/vpac270.h b/arch/arm/mach-pxa/include/mach/vpac270.h
index 0d82c47..7bfa3dd 100644
--- a/arch/arm/mach-pxa/include/mach/vpac270.h
+++ b/arch/arm/mach-pxa/include/mach/vpac270.h
@@ -37,4 +37,6 @@
 
 #define	GPIO36_VPAC270_IDE_IRQ		36
 
+#define	GPIO113_VPAC270_TS_IRQ		113
+
 #endif
diff --git a/arch/arm/mach-pxa/vpac270.c b/arch/arm/mach-pxa/vpac270.c
index 6575b8f..a1b39c4 100644
--- a/arch/arm/mach-pxa/vpac270.c
+++ b/arch/arm/mach-pxa/vpac270.c
@@ -388,7 +388,7 @@ static pxa2xx_audio_ops_t vpac270_ac97_pdata = {
 };
 
 static struct ucb1400_pdata vpac270_ucb1400_pdata = {
-	.irq		= IRQ_GPIO(113),
+	.irq		= IRQ_GPIO(GPIO113_VPAC270_TS_IRQ),
 };
 
 static struct platform_device vpac270_ucb1400_device = {
-- 
1.7.0
