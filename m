From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 13 Mar 2015 11:09:37 -0700
Subject: [PATCH 04/12] tty: serial: msm_serial: Remove dead code
In-Reply-To: <1426270185-19510-1-git-send-email-sboyd@codeaurora.org>
References: <1426270185-19510-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1426270185-19510-5-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This config no longer exists now that mach-msm has been removed.
Delete it and the associated code.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: David Brown <davidb@codeaurora.org>
Cc: Bryan Huntsman <bryanh@codeaurora.org>
Cc: Daniel Walker <dwalker@fifo99.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

This can be acked and go through arm-soc or applied directly to serial tree.

 drivers/tty/serial/Kconfig      | 2 +-
 drivers/tty/serial/msm_serial.h | 9 ---------
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 965c80f9fc50..049b9eb2e3e3 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1054,7 +1054,7 @@ config SERIAL_SGI_IOC3
 
 config SERIAL_MSM
 	bool "MSM on-chip serial port support"
-	depends on ARCH_MSM || ARCH_QCOM
+	depends on ARCH_QCOM
 	select SERIAL_CORE
 
 config SERIAL_MSM_CONSOLE
diff --git a/drivers/tty/serial/msm_serial.h b/drivers/tty/serial/msm_serial.h
index 3e1c7138d8cd..737f69fe7113 100644
--- a/drivers/tty/serial/msm_serial.h
+++ b/drivers/tty/serial/msm_serial.h
@@ -170,15 +170,6 @@ void msm_serial_set_mnd_regs_from_uartclk(struct uart_port *port)
 		msm_serial_set_mnd_regs_tcxoby4(port);
 }
 
-/*
- * TROUT has a specific defect that makes it report it's uartclk
- * as 19.2Mhz (TCXO) when it's actually 4.8Mhz (TCXO/4). This special
- * cases TROUT to use the right clock.
- */
-#ifdef CONFIG_MACH_TROUT
-#define msm_serial_set_mnd_regs msm_serial_set_mnd_regs_tcxoby4
-#else
 #define msm_serial_set_mnd_regs msm_serial_set_mnd_regs_from_uartclk
-#endif
 
 #endif	/* __DRIVERS_SERIAL_MSM_SERIAL_H */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
