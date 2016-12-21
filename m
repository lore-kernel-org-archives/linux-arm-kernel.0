From: baolin.wang@linaro.org (Baolin Wang)
Date: Wed, 21 Dec 2016 14:10:47 +0800
Subject: [PATCH 1/3] extcon: Add documentation for EXTCON_CHG_USB_* and
 EXTCON_USB_*
Message-ID: <7b9836ce2ca34118a2acd1ea113605a5f13b4439.1482300213.git.baolin.wang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current there is both "EXTCON_USB" and "EXTCON_CHG_USB_SDP" which
both seem to suggest a standard downstream port. But there is no
documentation describing how these relate.

Thus add documentation to describe EXTCON_CHG_USB_SDP should always
appear together with EXTCON_USB, and EXTCON_CHG_USB_ACA would normally
appear with EXTCON_USB_HOST.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 include/linux/extcon.h |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/extcon.h b/include/linux/extcon.h
index b871c0c..6498b05 100644
--- a/include/linux/extcon.h
+++ b/include/linux/extcon.h
@@ -46,7 +46,14 @@
 #define EXTCON_USB		1
 #define EXTCON_USB_HOST		2
 
-/* Charging external connector */
+/*
+ * Charging external connector
+ *
+ * When one SDP charger connector was reported, we should also report
+ * the USB connector, which means EXTCON_CHG_USB_SDP should always
+ * appear together with EXTCON_USB. The same as ACA charger connector,
+ * EXTCON_CHG_USB_ACA should always appear with EXTCON_USB_HOST.
+ */
 #define EXTCON_CHG_USB_SDP	5	/* Standard Downstream Port */
 #define EXTCON_CHG_USB_DCP	6	/* Dedicated Charging Port */
 #define EXTCON_CHG_USB_CDP	7	/* Charging Downstream Port */
-- 
1.7.9.5
