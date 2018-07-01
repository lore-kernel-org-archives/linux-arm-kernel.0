From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun,  1 Jul 2018 13:07:51 +0200
Subject: [RFC net-next 02/15] net: lora: Define sockaddr_lora
In-Reply-To: <20180701110804.32415-1-afaerber@suse.de>
References: <20180701110804.32415-1-afaerber@suse.de>
Message-ID: <20180701110804.32415-3-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prepare a uapi linux/lora.h header defining sockaddr_lora for AF_LORA.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 include/uapi/linux/lora.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 include/uapi/linux/lora.h

diff --git a/include/uapi/linux/lora.h b/include/uapi/linux/lora.h
new file mode 100644
index 000000000000..9368e8a84f3a
--- /dev/null
+++ b/include/uapi/linux/lora.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: (GPL-2.0-or-later WITH Linux-syscall-note) */
+/*
+ * linux/lora.h
+ *
+ * Copyright (c) 2017-2018 Andreas F?rber
+ */
+#ifndef _UAPI_LINUX_LORA_H
+#define _UAPI_LINUX_LORA_H
+
+#include <linux/types.h>
+#include <linux/socket.h>
+
+struct sockaddr_lora {
+	__kernel_sa_family_t lora_family;
+	int lora_ifindex;
+	union {
+	} lora_addr;
+};
+
+#endif /* _UAPI_LINUX_LORA_H */
-- 
2.16.4
