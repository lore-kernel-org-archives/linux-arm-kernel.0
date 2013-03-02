From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat,  2 Mar 2013 13:22:54 +0400
Subject: [PATCH 4/4] ARM: s3c24xx: Fix switching FIFO in arch_enable_uart_fifo
 function
In-Reply-To: <1362216174-10478-1-git-send-email-shc_work@mail.ru>
References: <1362216174-10478-1-git-send-email-shc_work@mail.ru>
Message-ID: <1362216174-10478-4-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When CONFIG_S3C_BOOT_UART_FORCE_FIFO symbol is set, we should
enable FIFO but actually switch command is missing in the code.
This patch adds this switch.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/plat-samsung/include/plat/uncompress.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/plat-samsung/include/plat/uncompress.h b/arch/arm/plat-samsung/include/plat/uncompress.h
index 438b248..30fedd9 100644
--- a/arch/arm/plat-samsung/include/plat/uncompress.h
+++ b/arch/arm/plat-samsung/include/plat/uncompress.h
@@ -130,6 +130,8 @@ static inline void arch_enable_uart_fifo(void)
 			if (!(fifocon & S3C2410_UFCON_RESETBOTH))
 				break;
 		}
+
+		uart_wr(S3C2410_UFCON, S3C2410_UFCON_FIFOMODE);
 	}
 }
 #else
-- 
1.7.12.4
