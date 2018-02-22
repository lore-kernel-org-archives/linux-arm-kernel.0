From: jacopo+renesas@jmondi.org (Jacopo Mondi)
Date: Thu, 22 Feb 2018 20:06:08 +0100
Subject: [PATCH 4/6] arm64: dts: renesas: r8a77965: Add #phy-cells property
In-Reply-To: <1519326370-15805-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1519326370-15805-1-git-send-email-jacopo+renesas@jmondi.org>
Message-ID: <1519326370-15805-5-git-send-email-jacopo+renesas@jmondi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add "#phy-cells" property to "usb-phy at e65ee000" device node.

This silences the following DTC compiler warning:
Warning (phys_property): Missing property '#phy-cells' in node
/soc/usb-phy at e65ee000 or bad phandle (referred from
/soc/usb at ee020000:phys[0])

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index be4f25c..cd12176 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -795,6 +795,7 @@
 
 		usb3_phy0: usb-phy at e65ee000 {
 			reg = <0 0xe65ee000 0 0x90>;
+			#phy-cells = <0>;
 			/* placeholder */
 		};
 
-- 
2.7.4
