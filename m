From: computersforpeace@gmail.com (Brian Norris)
Date: Wed,  4 Sep 2013 11:00:46 -0700
Subject: [PATCH] arm: mach-davinci: mark __maybe_unused struct
Message-ID: <1378317646-21262-1-git-send-email-computersforpeace@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If neither CONFIG_SND_DM365_AIC3X_CODEC nor CONFIG_SND_DM365_VOICE_CODEC
are defined, we may get warnings like:

    arch/arm/mach-davinci/board-dm365-evm.c:179:33: warning: 'dm365_evm_snd_data' defined but not used [-Wunused-variable]

To fix this, just mark the struct as __maybe_unused.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/mach-davinci/board-dm365-evm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index 4cdb61c..9be953e 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -176,7 +176,7 @@ static struct at24_platform_data eeprom_info = {
 	.context	= (void *)0x7f00,
 };
 
-static struct snd_platform_data dm365_evm_snd_data = {
+static struct snd_platform_data dm365_evm_snd_data __maybe_unused = {
 	.asp_chan_q = EVENTQ_3,
 };
 
-- 
1.8.4
