From: jacopo+renesas@jmondi.org (Jacopo Mondi)
Date: Tue, 27 Feb 2018 11:22:48 +0100
Subject: [PATCH v2 04/10] arm64: dts: renesas: eagle: Override EtherAVB
 phy-mode
In-Reply-To: <1519726974-23160-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1519726974-23160-1-git-send-email-jacopo+renesas@jmondi.org>
Message-ID: <1519726974-23160-5-git-send-email-jacopo+renesas@jmondi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the PHY interface installed on the Eagle board provides TX and RX
channels delays, make the "phy-mode" property a board-specific one,
meant to override the one specified in the SoC DTSI.

Follow up patches will reset the r8a77970 SoC DTSI to use "rgmii" mode
and let the board file override that.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 arch/arm64/boot/dts/renesas/r8a77970-eagle.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts b/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
index 359e835..3c5f598 100644
--- a/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
@@ -36,6 +36,7 @@
 &avb {
 	renesas,no-ether-link;
 	phy-handle = <&phy0>;
+	phy-mode = "rgmii-id";
 	status = "okay";
 
 	phy0: ethernet-phy at 0 {
-- 
2.7.4
