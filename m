From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 29 Jan 2016 15:06:26 +0100
Subject: [PATCH 2/9] ARM: pxa: mark spitz_card_pwr_ctrl as __maybe_unused
In-Reply-To: <1454076396-3563101-1-git-send-email-arnd@arndb.de>
References: <1454076396-3563101-1-git-send-email-arnd@arndb.de>
Message-ID: <1454076396-3563101-3-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This function is only used when CONFIG_PCMCIA is enabled, otherwise
we get a harmless warning:

arch/arm/mach-pxa/spitz.c:204:13: warning: 'spitz_card_pwr_ctrl' defined but not used [-Wunused-function]

Marking it as __maybe_unused keeps the logic simple and avoids the
warning on randconfig builds.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/spitz.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 825f903ab77e..d9578bc49fdc 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -201,7 +201,7 @@ static void __init spitz_scoop_init(void)
 }
 
 /* Power control is shared with between one of the CF slots and SD */
-static void spitz_card_pwr_ctrl(uint8_t enable, uint8_t new_cpr)
+static void __maybe_unused spitz_card_pwr_ctrl(uint8_t enable, uint8_t new_cpr)
 {
 	unsigned short cpr;
 	unsigned long flags;
-- 
2.7.0
