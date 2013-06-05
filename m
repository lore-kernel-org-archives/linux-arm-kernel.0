From: shc_work@mail.ru (Alexander Shiyan)
Date: Wed,  5 Jun 2013 09:59:10 +0400
Subject: [PATCH RESEND 02/15] ARM: clps711x: Set PLL clock to zero if we work
 from 13 mHz source
In-Reply-To: <1370411967-29451-1-git-send-email-shc_work@mail.ru>
References: <1370411967-29451-1-git-send-email-shc_work@mail.ru>
Message-ID: <1370411967-29451-3-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This clock will be used in audio subsystem. Since audio cannot work
without PLL we should indicate this.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-clps711x/common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-clps711x/common.c b/arch/arm/mach-clps711x/common.c
index 20ff50f..f42302e 100644
--- a/arch/arm/mach-clps711x/common.c
+++ b/arch/arm/mach-clps711x/common.c
@@ -301,6 +301,7 @@ void __init clps711x_timer_init(void)
 		cpu = ext;
 		bus = cpu;
 		spi = 135400;
+		pll = 0;
 	} else {
 		cpu = pll;
 		if (cpu >= 36864000)
-- 
1.8.1.5
