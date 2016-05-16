From: hotran@apm.com (Hoan Tran)
Date: Mon, 16 May 2016 09:17:25 -0700
Subject: [PATCH 1/3] Documentation: dtb: xgene: Add hwmon dts binding
 documentation
In-Reply-To: <1463415447-29903-1-git-send-email-hotran@apm.com>
References: <1463415447-29903-1-git-send-email-hotran@apm.com>
Message-ID: <1463415447-29903-2-git-send-email-hotran@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the APM X-Gene hwmon device tree node documentation.

Signed-off-by: Hoan Tran <hotran@apm.com>
---
 .../devicetree/bindings/hwmon/apm-xgene-hwmon.txt          | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/apm-xgene-hwmon.txt

diff --git a/Documentation/devicetree/bindings/hwmon/apm-xgene-hwmon.txt b/Documentation/devicetree/bindings/hwmon/apm-xgene-hwmon.txt
new file mode 100644
index 0000000..49a482e
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/apm-xgene-hwmon.txt
@@ -0,0 +1,14 @@
+APM X-Gene hwmon driver
+
+Hwmon driver accesses sensors over the "SLIMpro" mailbox.
+
+Required properties :
+ - compatible : should be "apm,xgene-slimpro-hwmon"
+ - mboxes : use the label reference for the mailbox as the first parameter.
+	    The second parameter is the channel number.
+
+Example :
+	hwmonslimpro {
+		compatible = "apm,xgene-slimpro-hwmon";
+		mboxes = <&mailbox 7>;
+	};
-- 
1.9.1
