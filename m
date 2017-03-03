From: horia.geanta@nxp.com (=?UTF-8?q?Horia=20Geant=C4=83?=)
Date: Fri, 3 Mar 2017 16:52:11 +0200
Subject: [RFC 5/7] crypto: caam - avoid double inclusion in desc_constr.h
In-Reply-To: <1488552733-20806-1-git-send-email-horia.geanta@nxp.com>
References: <1488552733-20806-1-git-send-email-horia.geanta@nxp.com>
Message-ID: <1488552733-20806-6-git-send-email-horia.geanta@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Horia Geant? <horia.geanta@nxp.com>
---
 drivers/crypto/caam/desc_constr.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/crypto/caam/desc_constr.h b/drivers/crypto/caam/desc_constr.h
index b9c8d98ef826..d8e83ca104e0 100644
--- a/drivers/crypto/caam/desc_constr.h
+++ b/drivers/crypto/caam/desc_constr.h
@@ -4,6 +4,9 @@
  * Copyright 2008-2012 Freescale Semiconductor, Inc.
  */
 
+#ifndef DESC_CONSTR_H
+#define DESC_CONSTR_H
+
 #include "desc.h"
 #include "regs.h"
 
@@ -491,3 +494,5 @@ static inline int desc_inline_query(unsigned int sd_base_len,
 
 	return (rem_bytes >= 0) ? 0 : -1;
 }
+
+#endif /* DESC_CONSTR_H */
-- 
2.4.4
