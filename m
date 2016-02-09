From: lee.jones@linaro.org (Lee Jones)
Date: Tue,  9 Feb 2016 14:27:07 +0000
Subject: [PATCH] mfd: Provide MACRO to declare commonly defined MFD cell
 attributes
Message-ID: <1455028027-1527-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Laxman Dewangan <ldewangan@nvidia.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 include/linux/mfd/core.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
index 27dac3f..dacdc49 100644
--- a/include/linux/mfd/core.h
+++ b/include/linux/mfd/core.h
@@ -16,6 +16,38 @@
 
 #include <linux/platform_device.h>
 
+#define MFD_CELL_ALL(_name, _res, _pdata, _id, _compat, _match)		\
+	{								\
+		.name = (_name),					\
+		.num_resources = ARRAY_SIZE((_res)),			\
+		.resources = (_res),					\
+		.platform_data = (_pdata),				\
+		.pdata_size = ARRAY_SIZE((_pdata)),			\
+		.of_compatible = (_compat),				\
+		.acpi_match = (_match),					\
+		.id = _id,						\
+	}
+
+#define OF_MFD_CELL(_name, _res, _pdata, _id, _compat)			\
+	{								\
+		MFD_CELL_ALL(_name, _res, _pdata, _id, _compat, NULL)	\
+	}
+
+#define ACPI_MFD_CELL(_name, _res, _pdata, _id, _match)			\
+	{								\
+		MFD_CELL_ALL(_name, _res, _pdata, _id, NULL, _match)	\
+	}
+
+#define MFD_CELL_BASIC(_name, _res, _pdata, _id)			\
+	{								\
+		MFD_CELL_ALL(_name, _res, _pdata, _id, NULL, NULL)	\
+	}
+
+#define MFD_CELL_NAME(_name)						\
+	{								\
+		MFD_CELL_ALL(_name, NULL, NULL, 0, NULL, NULL)		\
+	}
+
 struct irq_domain;
 
 /* Matches ACPI PNP id, either _HID or _CID, or ACPI _ADR */
-- 
1.9.1
