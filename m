From: alchaiken@gmail.com (alchaiken at gmail.com)
Date: Sat,  5 Dec 2015 19:30:57 -0800
Subject: [PATCH 2/2] ARM: dts: imx6qdl-sabreauto: enable partitions for
 parallel NOR
In-Reply-To: <1449372657-18496-1-git-send-email-alison_chaiken@mentor.com>
References: <1449372657-18496-1-git-send-email-alison_chaiken@mentor.com>
Message-ID: <1449372657-18496-3-git-send-email-alison_chaiken@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alison Chaiken <alison_chaiken@mentor.com>

Add a 'partitions' property to the nor child of the WEIM bus so
that ofpart will allow partiton creation.

Signed-off-by: Alison Chaiken <alison_chaiken@mentor.com>
---
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index 530b4d6..10293f2 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -626,5 +626,9 @@
 		fsl,weim-cs-timing = <0x00620081 0x00000001 0x1c022000
 				0x0000c000 0x1404a38e 0x00000000>;
 		nor-gpios = <&gpio5 4 GPIO_ACTIVE_LOW>;
+		partitions at 0 {
+			label = "pnor";
+			reg = <0x0 0x1000000>;
+		};
 	};
 };
-- 
2.6.2
