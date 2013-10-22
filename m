From: sre@debian.org (Sebastian Reichel)
Date: Tue, 22 Oct 2013 14:56:17 +0200
Subject: [PATCH 2/2] DTS: ARM: OMAP3-N900: Add bq27200 battery monitor
In-Reply-To: <1382446577-28270-1-git-send-email-sre@debian.org>
References: <1382446577-28270-1-git-send-email-sre@debian.org>
Message-ID: <1382446577-28270-2-git-send-email-sre@debian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support the bq27200 battery monitor chip.

Signed-off-by: Sebastian Reichel <sre@debian.org>
---
 arch/arm/boot/dts/omap3-n900.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 60cb33f..992338c 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -240,6 +240,11 @@
 	pinctrl-0 = <&i2c2_pins>;
 
 	clock-frequency = <100000>;
+
+	bq27200: bq27200 at 55 {
+		compatible = "ti,bq27200";
+		reg = <0x55>;
+	};
 };
 
 &i2c3 {
-- 
1.8.4.rc3
