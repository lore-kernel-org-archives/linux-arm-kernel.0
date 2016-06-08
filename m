From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 08 Jun 2016 15:48:02 +0200
Subject: [RFC v4 3/7] extcon: Add raw VBUS and ID cable states
In-Reply-To: <1465393686-16644-1-git-send-email-k.kozlowski@samsung.com>
References: <1465393686-16644-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1465393686-16644-4-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The USB controller driver might want to receive the changes for VBUS and
ID pins so it could properly handle USB OTG. Add new cable states for
that purpose.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

Previous discussion:
http://lkml.kernel.org/g/<1427980385-21285-3-git-send-email-r.baldyga@samsung.com>
---
 drivers/extcon/extcon.c | 3 +++
 include/linux/extcon.h  | 8 +++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index 21a123cadf78..aa02d94e8a78 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -74,6 +74,9 @@ static const char *extcon_name[] =  {
 	[EXTCON_JIG]			= "JIG",
 	[EXTCON_MECHANICAL]		= "MECHANICAL",
 
+	[EXTCON_USB_ID]			= "USB-ID",
+	[EXTCON_USB_VBUS]		= "USB-VBUS",
+
 	NULL,
 };
 
diff --git a/include/linux/extcon.h b/include/linux/extcon.h
index 7abf674c388c..126ae41b84fd 100644
--- a/include/linux/extcon.h
+++ b/include/linux/extcon.h
@@ -66,7 +66,13 @@
 #define EXTCON_JIG		61
 #define EXTCON_MECHANICAL	62
 
-#define EXTCON_NUM		63
+/* Raw status, useful for USB controllers */
+#define EXTCON_USB_ID		63
+#define EXTCON_USB_VBUS		64
+
+#define EXTCON_NUM		65
+
+
 
 struct extcon_cable;
 
-- 
1.9.1
