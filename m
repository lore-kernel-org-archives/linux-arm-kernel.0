From: hkallweit1@gmail.com (Heiner Kallweit)
Date: Mon, 9 Oct 2017 20:49:44 +0200
Subject: [PATCH 1/3] firmware: arm_scpi: remove default for get_scpi_ops if
 not reachable
Message-ID: <8afb173f-1480-baf8-e15b-5c01ed033671@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All callers of get_scpi_ops() depend on the result and therefore have
a Kconfig dependency on ARM_SCPI_PROTOCOL. Means that ARM_SCPI_PROTOCOL
being a module and caller being built-in can't occur.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 include/linux/scpi_protocol.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/scpi_protocol.h b/include/linux/scpi_protocol.h
index 327d6566..d5eba00d 100644
--- a/include/linux/scpi_protocol.h
+++ b/include/linux/scpi_protocol.h
@@ -77,8 +77,4 @@ struct scpi_ops {
 	int (*device_set_power_state)(u16, u8);
 };
 
-#if IS_REACHABLE(CONFIG_ARM_SCPI_PROTOCOL)
 struct scpi_ops *get_scpi_ops(void);
-#else
-static inline struct scpi_ops *get_scpi_ops(void) { return NULL; }
-#endif
-- 
2.14.2
