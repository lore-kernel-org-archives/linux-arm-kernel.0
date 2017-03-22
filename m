From: clg@kaod.org (=?UTF-8?q?C=C3=A9dric=20Le=20Goater?=)
Date: Wed, 22 Mar 2017 17:04:43 +0100
Subject: [PATCH] ARM: dts: aspeed: add SPI controller bindings to Romulus
Message-ID: <1490198683-5796-1-git-send-email-clg@kaod.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Romulus systems have one MX25L25635 (32768 Kbytes) flash module for
the BMC firmware and other MT25QL512A (65536 Kbytes) for the host.

Signed-off-by: C?dric Le Goater <clg@kaod.org>
---
 arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts b/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
index 7a3b2b50c884..e3c6358bc7d9 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
@@ -31,6 +31,26 @@
 	};
 };
 
+&fmc {
+	status = "okay";
+	flash at 0 {
+		status = "okay";
+		label = "bmc";
+	};
+};
+
+&spi1 {
+	status = "okay";
+	flash at 0 {
+		status = "okay";
+		label = "pnor";
+	};
+};
+
+&spi2 {
+	status = "okay";
+};
+
 &uart5 {
 	status = "okay";
 };
-- 
2.7.4
