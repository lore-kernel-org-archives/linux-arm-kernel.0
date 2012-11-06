From: anilkumar@ti.com (AnilKumar Ch)
Date: Tue, 6 Nov 2012 19:18:32 +0530
Subject: [PATCH RESEND 04/10] ARM: dts: AM33XX: Add volume-keys device tree
 data to am335x-evm
In-Reply-To: <1352209718-5586-1-git-send-email-anilkumar@ti.com>
References: <1352209718-5586-1-git-send-email-anilkumar@ti.com>
Message-ID: <1352209718-5586-5-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add gpio based volume keys device tree data to am335x-evm by adding
all the required parameters like keycode, gpios and etc.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/am335x-evm.dts |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index e087b87..9f65f17 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -137,6 +137,27 @@
 				0x0101001c	/* ENTER */
 				0x0201006c>;	/* DOWN */
 	};
+
+	gpio_keys: volume_keys at 0 {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		autorepeat;
+
+		switch at 9 {
+			label = "volume-up";
+			linux,code = <115>;
+			gpios = <&gpio1 2 1>;
+			gpio-key,wakeup;
+		};
+
+		switch at 10 {
+			label = "volume-down";
+			linux,code = <114>;
+			gpios = <&gpio1 3 1>;
+			gpio-key,wakeup;
+		};
+	};
 };
 
 /include/ "tps65910.dtsi"
-- 
1.7.9.5
