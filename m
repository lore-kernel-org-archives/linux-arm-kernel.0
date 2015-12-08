From: alison_chaiken@mentor.com (Alison Chaiken)
Date: Tue, 8 Dec 2015 15:48:40 -0800
Subject: [PATCH v2 2/2] ARM: dts: imx6qdl-sabreauto: enable partitions for
 parallel NOR
In-Reply-To: <1449618520-3432-1-git-send-email-alison_chaiken@mentor.com>
References: <20151207082440.GY11966@pengutronix.de>
 <1449618520-3432-1-git-send-email-alison_chaiken@mentor.com>
Message-ID: <1449618520-3432-3-git-send-email-alison_chaiken@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a 'partitions' property to the nor child of the WEIM bus so
that ofpart will allow partition creation.

Signed-off-by: Alison Chaiken <alison_chaiken@mentor.com>
---
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index 8263fc1..1a29fff 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -625,5 +625,9 @@
 		bank-width = <2>;
 		fsl,weim-cs-timing = <0x00620081 0x00000001 0x1c022000
 				0x0000c000 0x1404a38e 0x00000000>;
+		partitions at 0 {
+			label = "pnor";
+			reg = <0x0 0x1000000>;
+		};
 	};
 };
-- 
2.6.2
