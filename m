From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Wed, 30 Jul 2014 20:14:01 +0200
Subject: [PATCH v14 8/8] ARM: berlin: enable the eSATA interface on the BG2Q
 DMP
In-Reply-To: <1406744041-1269-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1406744041-1269-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1406744041-1269-9-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The BG2Q has an AHCI SATA controller with an eSATA interface. Enable it.
Only enable the first port, the BG2Q DMP does not support the second one.

Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2q-marvell-dmp.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
index 995150f93795..385f6af64d0c 100644
--- a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
+++ b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
@@ -37,3 +37,11 @@
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
