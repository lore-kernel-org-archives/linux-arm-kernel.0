From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Tue, 22 Apr 2014 17:38:23 +0200
Subject: [PATCH 4/6] ARM: berlin: enable the eSATA interface on the BG2Q DMP
In-Reply-To: <1398181105-19714-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1398181105-19714-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1398181105-19714-5-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The BG2Q has an AHCI SATA controller with an eSATA interface. Enable it.

Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2q-marvell-dmp.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
index 2da9c41e29d8..26047ceed603 100644
--- a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
+++ b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
@@ -26,3 +26,8 @@
 &uart0 {
 	status = "okay";
 };
+
+&ahci {
+	status = "okay";
+	marvell,force-port-map = <1>;
+};
-- 
1.8.3.2
