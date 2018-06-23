From: david@lechnology.com (David Lechner)
Date: Sat, 23 Jun 2018 16:08:10 -0500
Subject: [PATCH 8/8] ARM: dts: am33xx: add node for PRU remoteproc
In-Reply-To: <20180623210810.21232-1-david@lechnology.com>
References: <20180623210810.21232-1-david@lechnology.com>
Message-ID: <20180623210810.21232-9-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a new node to am33xx.dtsi for binding the PRUSS as a
remoteproc device.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 9cd62bc2ca35..1e7837af4689 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -924,6 +924,15 @@
 			};
 		};
 
+		pru_rproc: cpu at 4a300000 {
+			compatible = "ti,am3352-pru-rproc";
+			reg = <0x4a300000 0x80000>;
+			interrupts = <20>, <21>;
+			interrupt-names = "pru0-vq", "pru1-vq";
+			ti,hwmods = "pruss";
+			status = "disabled";
+		};
+
 		elm: elm at 48080000 {
 			compatible = "ti,am3352-elm";
 			reg = <0x48080000 0x2000>;
-- 
2.17.1
