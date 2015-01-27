From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 27 Jan 2015 15:10:16 +0100
Subject: [PATCH 9/9] ARM: berlin: enable flash on the BG2Q DMP
In-Reply-To: <1422367816-4257-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1422367816-4257-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1422367816-4257-10-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The BG2Q DMP has a nand controller. Enable it with the correct
configuration.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2q-marvell-dmp.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
index a98ac1bd8f65..0bfdff5ca86f 100644
--- a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
+++ b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
@@ -112,3 +112,13 @@
 &sata_phy {
 	status = "okay";
 };
+
+&nand0 {
+	marvell,nand-enable-arbiter;
+	nand-ecc-strength = <48>;
+	nand-ecc-step-size = <1024>;
+
+	num-cs = <1>;
+
+	status = "okay";
+};
-- 
2.2.2
