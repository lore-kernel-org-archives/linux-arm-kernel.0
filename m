From: shc_work@mail.ru (Alexander Shiyan)
Date: Tue,  2 Jul 2013 23:16:33 +0400
Subject: [PATCH RESEND] ARM: plat-samsung: Fix switching FIFO in
 arch_enable_uart_fifo function
Message-ID: <1372792593-7457-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When CONFIG_S3C_BOOT_UART_FORCE_FIFO symbol is set, we should
enable FIFO but actually switch command is missing in the code.
This patch adds this switching.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/plat-samsung/include/plat/uncompress.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/plat-samsung/include/plat/uncompress.h b/arch/arm/plat-samsung/include/plat/uncompress.h
index 4afc32f..f48dc0a 100644
--- a/arch/arm/plat-samsung/include/plat/uncompress.h
+++ b/arch/arm/plat-samsung/include/plat/uncompress.h
@@ -145,6 +145,8 @@ static inline void arch_enable_uart_fifo(void)
 			if (!(fifocon & S3C2410_UFCON_RESETBOTH))
 				break;
 		}
+
+		uart_wr(S3C2410_UFCON, S3C2410_UFCON_FIFOMODE);
 	}
 }
 #else
-- 
1.8.1.5
