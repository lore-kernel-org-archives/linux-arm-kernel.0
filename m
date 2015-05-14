From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 14 May 2015 18:11:07 +0200
Subject: [PATCH 4/4] ARM: ux500: define the backupram in the device tree
In-Reply-To: <1431619867-14700-1-git-send-email-linus.walleij@linaro.org>
References: <1431619867-14700-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1431619867-14700-5-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Ux500 SOCs have a special backup RAM that needs to be
defined in the device tree.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-dbx5x0.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index f024a1c0de8b..853684ad7773 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -190,6 +190,15 @@
 			reg = <0xa0410000 0x100>;
 		};
 
+		/*
+		 * The backup RAM is used for retention during sleep
+		 * and various things like spin tables
+		 */
+		backupram at 80150000 {
+			compatible = "ste,dbx500-backupram";
+			reg = <0x80150000 0x2000>;
+		};
+
 		L2: l2-cache {
 			compatible = "arm,pl310-cache";
 			reg = <0xa0412000 0x1000>;
-- 
1.9.3
