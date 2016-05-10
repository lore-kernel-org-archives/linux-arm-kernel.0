From: serveralex@gmail.com (=?UTF-8?q?Alexander=20M=C3=BCller?=)
Date: Tue, 10 May 2016 22:08:40 +0200
Subject: [PATCH 6/6] ARM: DTS: Amlogic: Enable ethernet on ODROID-C1
In-Reply-To: <1462910920-5462-1-git-send-email-serveralex@gmail.com>
References: <1462910920-5462-1-git-send-email-serveralex@gmail.com>
Message-ID: <1462910920-5462-7-git-send-email-serveralex@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ODROID-C1 uses Amlogic meson8b integrated ethernet IC (compatible with
stmmac) and a Realtek RTL8211F gigabit ethernet PHY. The reset pin is
connected to GPIOH_4.

Signed-off-by: Alexander M?ller <serveralex@gmail.com>
---
 arch/arm/boot/dts/meson8b-odroidc1.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
index e50f1a1..44410d9 100644
--- a/arch/arm/boot/dts/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
@@ -76,3 +76,13 @@
 	pinctrl-0 = <&uart_ao_a_pins>;
 	pinctrl-names = "default";
 };
+
+&ethmac {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&ethernet_pins>;
+	snps,reset-gpio = <&gpio GPIOH_4 GPIO_ACTIVE_HIGH>;
+	snps,reset-active-low;
+	snps,reset-delays-us = <0 10000 50000>;
+};
+
-- 
2.5.0
