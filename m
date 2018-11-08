From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 8 Nov 2018 10:37:50 +0200
Subject: [RFC 5/9] ARM: davinci: dm365-evm: Update for the new ASoC Kcofnig
 options
In-Reply-To: <20181108083754.1746-1-peter.ujfalusi@ti.com>
References: <20181108083754.1746-1-peter.ujfalusi@ti.com>
Message-ID: <20181108083754.1746-6-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The codec selection config options for DMA365 has been changed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-davinci/board-dm365-evm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index 8143756ff38b..09e439d4abf5 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -794,9 +794,9 @@ static __init void dm365_evm_init(void)
 	/* maybe setup mmc1/etc ... _after_ mmc0 */
 	evm_init_cpld();
 
-#ifdef CONFIG_SND_DM365_AIC3X_CODEC
+#ifdef CONFIG_SND_SOC_DM365_AIC3X_CODEC
 	dm365_init_asp();
-#elif defined(CONFIG_SND_DM365_VOICE_CODEC)
+#elif defined(CONFIG_SND_SOC_DM365_VOICE_CODEC)
 	dm365_init_vc();
 #endif
 	dm365_init_rtc();
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
