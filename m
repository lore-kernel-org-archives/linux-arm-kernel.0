From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Tue, 22 Apr 2014 10:27:28 +0200
Subject: [PATCH v2 2/2] ARM: dts: berlin: enable SD card reader and eMMC for
 the BG2Q DMP
In-Reply-To: <1398155248-1659-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1398155248-1659-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1398155248-1659-3-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the SD Card reader and the internal eMMC on the Berlin BG2Q DMP
using two of the SDHCI nodes of the Berlin BG2Q.

Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2q-marvell-dmp.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
index 2da9c41e29d8..6ca8c9e52b08 100644
--- a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
+++ b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
@@ -26,3 +26,14 @@
 &uart0 {
 	status = "okay";
 };
+
+&sdhci1 {
+	broken-cd;
+	sdhci,wp-inverted;
+	status = "okay";
+};
+
+&sdhci2 {
+	non-removable;
+	status = "okay";
+};
-- 
1.8.3.2
