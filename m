From: xiexiuqi@huawei.com (Xie XiuQi)
Date: Wed, 27 Sep 2017 20:50:17 +0800
Subject: [PATCH v4 1/4] ACPI, CPER: add arm error info type definition
In-Reply-To: <1506516620-20033-1-git-send-email-xiexiuqi@huawei.com>
References: <1506516620-20033-1-git-send-email-xiexiuqi@huawei.com>
Message-ID: <1506516620-20033-2-git-send-email-xiexiuqi@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add arm error info type definition according to ACPI6.1
Table 261. ARM Processor Error Information Structure,
which is used for error recovery in the following patches.

Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
---
 include/linux/cper.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/cper.h b/include/linux/cper.h
index 723e952..9106e2b 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -275,6 +275,11 @@ enum {
 #define CPER_ARM_INFO_FLAGS_PROPAGATED		BIT(2)
 #define CPER_ARM_INFO_FLAGS_OVERFLOW		BIT(3)
 
+#define CPER_ARM_INFO_TYPE_CACHE		0
+#define CPER_ARM_INFO_TYPE_TLB			1
+#define CPER_ARM_INFO_TYPE_BUS			2
+#define CPER_ARM_INFO_TYPE_UARCH		3
+
 /*
  * All tables and structs must be byte-packed to match CPER
  * specification, since the tables are provided by the system BIOS
-- 
1.8.3.1
