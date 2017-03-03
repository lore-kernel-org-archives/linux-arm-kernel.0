From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri,  3 Mar 2017 23:18:48 +0000
Subject: [PATCH V10 5/6] ARM64: dts: bcm2837: Define CPU thermal coefficients
In-Reply-To: <1488583129-4159-1-git-send-email-stefan.wahren@i2se.com>
References: <1488583129-4159-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1488583129-4159-6-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This defines the bcm2837 SoC specific thermal coefficients in
order to initialize the thermal driver correctly.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm64/boot/dts/broadcom/bcm2837.dtsi |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2837.dtsi b/arch/arm64/boot/dts/broadcom/bcm2837.dtsi
index 19f2fe6..666c713 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2837.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcm2837.dtsi
@@ -75,6 +75,10 @@
 	interrupts = <8>;
 };
 
+&cpu_thermal {
+	coefficients = <(-538)	412000>;
+}
+
 /* enable thermal sensor with the correct compatible property set */
 &thermal {
 	compatible = "brcm,bcm2837-thermal";
-- 
1.7.9.5
