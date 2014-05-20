From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Tue, 20 May 2014 11:04:35 +0200
Subject: [PATCH v4 7/7] ARM: berlin: enable the eSATA interface on the BG2Q DMP
In-Reply-To: <1400576675-25265-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1400576675-25265-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1400576675-25265-8-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The BG2Q has an AHCI SATA controller with an eSATA interface. Enable it.
Only enable the first port, the BG2Q DMP does not support the second one.

Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2q-marvell-dmp.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
index 2da9c41e29d8..899b4e04fe12 100644
--- a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
+++ b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
@@ -26,3 +26,11 @@
 &uart0 {
 	status = "okay";
 };
+
+&sata0 {
+	status = "okay";
+};
+
+&sata_phy {
+	status = "okay";
+};
-- 
1.9.1
