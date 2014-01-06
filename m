From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 06 Jan 2014 19:37:45 +0100
Subject: [PATCH 1/5] dt-bindings: document the s3c24xx software-reset register
In-Reply-To: <3105326.uFdOVLyXH8@phil>
References: <3105326.uFdOVLyXH8@phil>
Message-ID: <2635551.Gy9A9uhyAA@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The S3C2412/S3C2413 as well as the S3C2443 and following contain a special
register that restarts the system when written to. This adds a simple
binding, so that it gets accessible on dt systems too.

We distinguish between the two types (s3c2412, s3c2443) because the
handling of the swrst register on the s3c2412 also needs to take care
of a hardware glitch at reset time.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../devicetree/bindings/arm/samsung/s3c24xx-swrst.txt  |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/samsung/s3c24xx-swrst.txt

diff --git a/Documentation/devicetree/bindings/arm/samsung/s3c24xx-swrst.txt b/Documentation/devicetree/bindings/arm/samsung/s3c24xx-swrst.txt
new file mode 100644
index 0000000..c3cacf2
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/samsung/s3c24xx-swrst.txt
@@ -0,0 +1,16 @@
+SAMSUNG S3C24XX software-reset register
+
+Some SoCs of the series contain a special software-reset register
+to let the system restart.
+
+Properties:
+ - compatible : should be one of
+    "samsung,s3c2412-swrst" - for S3C2412, S3C2413
+    "samsung,s3c2443-swrst" - for S3C2416, S3C2443, S3C2450
+ - reg : offset and length of the register.
+
+Example:
+	swrst at 4c000044 {
+		compatible = "samsung,s3c2443-swrst";
+		reg = <0x4c000044 0x4>;
+	};
-- 
1.7.10.4
