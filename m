From: david@lechnology.com (David Lechner)
Date: Tue, 22 Nov 2016 21:29:27 -0600
Subject: [PATCH 3/3] ARM: dts: da850: Add node for pullup/pulldown pinconf
In-Reply-To: <1479871767-20160-1-git-send-email-david@lechnology.com>
References: <1479871767-20160-1-git-send-email-david@lechnology.com>
Message-ID: <1479871767-20160-4-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This SoC has a separate pin controller for configuring pullup/pulldown
bias on groups of pins.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/boot/dts/da850.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 8945815..1c0224c 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -210,6 +210,11 @@
 			};
 
 		};
+		pinconf: pin-controller at 22c00c {
+			compatible = "ti,da850-pupd";
+			reg = <0x22c00c 0x8>;
+			status = "disabled";
+		};
 		prictrl: priority-controller at 14110 {
 			compatible = "ti,da850-mstpri";
 			reg = <0x14110 0x0c>;
-- 
2.7.4
