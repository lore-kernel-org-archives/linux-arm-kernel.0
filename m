From: fkan@apm.com (Feng Kan)
Date: Tue,  7 Oct 2014 17:06:48 -0700
Subject: [PATCH 5/6] Documentation: i2c: Add APM X-Gene platform SLIMpro I2C
 driver documentation
In-Reply-To: <1412726809-7525-1-git-send-email-fkan@apm.com>
References: <1412726809-7525-1-git-send-email-fkan@apm.com>
Message-ID: <1412726809-7525-6-git-send-email-fkan@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add APM X-Gene platform SLIMpro I2C driver documentation.

Signed-off-by: Feng Kan <fkan@apm.com>
Signed-off-by: Hieu Le <hnle@apm.com>
---
 .../devicetree/bindings/i2c/i2c-xgene-slimpro.txt    | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-xgene-slimpro.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-xgene-slimpro.txt b/Documentation/devicetree/bindings/i2c/i2c-xgene-slimpro.txt
new file mode 100644
index 0000000..1a79d53
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-xgene-slimpro.txt
@@ -0,0 +1,20 @@
+APM X-Gene SLIMpro Mailbox I2C Driver
+
+This is a I2C driver that access the I2C bus through the mailbox mechanism.
+There is documentation of the mailbox driver in the
+Documentation/devicetree/binding/mailbox/xgene-slimpro-mbox.txt
+
+Required properties :
+
+ - compatible : should be "apm,xgene-slimpro-i2c"
+ - mbox : ptr to the mailbox dts node, use the name of the mailbox as the
+	  first parameter. The second parameter is the channel number.
+	  The APM X-Gene SLIMpro mailbox has 8 channels.
+ - mbox-names : the name of the mailbox channel.
+
+Example :
+	i2cslimpro {
+		compatible = "apm,xgene-slimpro-i2c";
+		mbox = <&mailbox 0>;
+		mbox-names = "i2c-slimpro";
+	};
-- 
1.9.1
