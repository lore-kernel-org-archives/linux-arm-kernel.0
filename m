From: voice.shen@atmel.com (Bo Shen)
Date: Thu,  4 Jul 2013 15:16:42 +0800
Subject: [PATCH 4/4] arm: atmel: sam9n12: enable kernel uncompress info output
In-Reply-To: <1372922202-28606-1-git-send-email-voice.shen@atmel.com>
References: <1372922202-28606-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1372922202-28606-5-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

the sam9n12 use the same array usart as sam9x5, add it which will
enable output kernel uncompress info:
---8>---
Uncompressing Linux... done, booting the kernel.
---<8---

Signed-off-by: Bo Shen <voice.shen@atmel.com>

---
 arch/arm/mach-at91/include/mach/uncompress.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-at91/include/mach/uncompress.h b/arch/arm/mach-at91/include/mach/uncompress.h
index fe097e6..4bb644f 100644
--- a/arch/arm/mach-at91/include/mach/uncompress.h
+++ b/arch/arm/mach-at91/include/mach/uncompress.h
@@ -130,6 +130,7 @@ static inline const u32* decomp_soc_detect(void __iomem *dbgu_base)
 	case ARCH_ID_AT91SAM9RL64:
 		return uarts_sam9rl;
 
+	case ARCH_ID_AT91SAM9N12:
 	case ARCH_ID_AT91SAM9X5:
 		return uarts_sam9x5;
 
-- 
1.7.9.5
