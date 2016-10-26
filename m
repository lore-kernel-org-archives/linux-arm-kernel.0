From: david@lechnology.com (David Lechner)
Date: Tue, 25 Oct 2016 22:06:50 -0500
Subject: [PATCH v6 4/5] ARM: DTS: da850: Add cfgchip syscon node
In-Reply-To: <1477451211-31979-1-git-send-email-david@lechnology.com>
References: <1477451211-31979-1-git-send-email-david@lechnology.com>
Message-ID: <1477451211-31979-5-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a syscon node for the SoC CFGCHIPn registers. This is needed for
the new usb phy driver.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/boot/dts/da850.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index f79e1b9..6bbf20d 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -188,6 +188,10 @@
 			};
 
 		};
+		cfgchip: cfgchip at 1417c {
+			compatible = "ti,da830-cfgchip", "syscon";
+			reg = <0x1417c 0x14>;
+		};
 		edma0: edma at 0 {
 			compatible = "ti,edma3-tpcc";
 			/* eDMA3 CC0: 0x01c0 0000 - 0x01c0 7fff */
-- 
2.7.4
