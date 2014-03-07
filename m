From: r.sricharan@ti.com (Sricharan R)
Date: Fri, 7 Mar 2014 17:46:13 +0530
Subject: [RFC PATCH 6/9] arm: dts: dra: Add dma crossbar node
In-Reply-To: <1394194576-23741-1-git-send-email-r.sricharan@ti.com>
References: <1394194576-23741-1-git-send-email-r.sricharan@ti.com>
Message-ID: <1394194576-23741-7-git-send-email-r.sricharan@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding the crossbar node.

Signed-off-by: Sricharan R <r.sricharan@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 1fd75aa..f84991b 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -170,6 +170,13 @@
 			#dma-requests = <127>;
 		};
 
+		dmacb: crossbar at 4a020000 {
+			compatible = "ti,dma-crossbar";
+			reg = <0x4a002b78 0x100>;
+			ti,dma-reqs = <160>;
+			ti,reg-size = <2>;
+		};
+
 		gpio1: gpio at 4ae10000 {
 			compatible = "ti,omap4-gpio";
 			reg = <0x4ae10000 0x200>;
-- 
1.7.9.5
