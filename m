From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue, 14 Nov 2017 00:34:27 +0100
Subject: [PATCH v2 8/8] arm64: dts: actions: Add S700 SPS node
In-Reply-To: <20171113233427.5386-1-afaerber@suse.de>
References: <20171113233427.5386-1-afaerber@suse.de>
Message-ID: <20171113233427.5386-9-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a node to the S700 Device Tree for the Smart Power System (SPS).

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v2: New
 
 To be squashed into 5/8 if binding gets acked.
 
 arch/arm64/boot/dts/actions/s700.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
index b54df405aaeb..6a39968b209f 100644
--- a/arch/arm64/boot/dts/actions/s700.dtsi
+++ b/arch/arm64/boot/dts/actions/s700.dtsi
@@ -154,6 +154,12 @@
 			status = "disabled";
 		};
 
+		sps: power-controller at e01b0100 {
+			compatible = "actions,s700-sps";
+			reg = <0x0 0xe01b0100 0x0 0x100>;
+			#power-domain-cells = <1>;
+		};
+
 		timer: timer at e024c000 {
 			compatible = "actions,s700-timer";
 			reg = <0x0 0xe024c000 0x0 0x4000>;
-- 
2.13.6
