From: jacopo+renesas@jmondi.org (Jacopo Mondi)
Date: Tue, 27 Feb 2018 11:22:53 +0100
Subject: [PATCH v2 09/10] arm64: dts: renesas: r8a77970: Set EtherAVB phy mode
 to "rgmii"
In-Reply-To: <1519726974-23160-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1519726974-23160-1-git-send-email-jacopo+renesas@jmondi.org>
Message-ID: <1519726974-23160-10-git-send-email-jacopo+renesas@jmondi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set the "phy-mode" property of EtherAVB device to "rgmii" and let board
files override it if the installed PHY layer provides delays for the
RX/TX channels.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 arch/arm64/boot/dts/renesas/r8a77970.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77970.dtsi b/arch/arm64/boot/dts/renesas/r8a77970.dtsi
index de84df3..955fded 100644
--- a/arch/arm64/boot/dts/renesas/r8a77970.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77970.dtsi
@@ -607,7 +607,7 @@
 			clocks = <&cpg CPG_MOD 812>;
 			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
 			resets = <&cpg 812>;
-			phy-mode = "rgmii-id";
+			phy-mode = "rgmii";
 			iommus = <&ipmmu_rt 3>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.7.4
