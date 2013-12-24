From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 24 Dec 2013 23:24:06 +0100
Subject: [PATCH 4/5] ARM: dts: sun5i: Add rtp controller node
In-Reply-To: <1387923847-1294-1-git-send-email-hdegoede@redhat.com>
References: <1387923847-1294-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1387923847-1294-5-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun5i-a10s.dtsi | 7 +++++++
 arch/arm/boot/dts/sun5i-a13.dtsi  | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 948eb10..df9ba3b 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -409,6 +409,13 @@
 			reg = <0x01c23800 0x10>;
 		};
 
+		rtp: rtp at 01c25000 {
+			compatible = "allwinner,sun4i-ts";
+			reg = <0x01c25000 0x100>;
+			interrupts = <29>;
+			ts-attached = <0>;
+		};
+
 		uart0: serial at 01c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index ca15672..4de2adb 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -367,6 +367,13 @@
 			reg = <0x01c23800 0x10>;
 		};
 
+		rtp: rtp at 01c25000 {
+			compatible = "allwinner,sun4i-ts";
+			reg = <0x01c25000 0x100>;
+			interrupts = <29>;
+			ts-attached = <0>;
+		};
+
 		uart1: serial at 01c28400 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28400 0x400>;
-- 
1.8.4.2
