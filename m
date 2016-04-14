From: brian.starkey@arm.com (Brian Starkey)
Date: Thu, 14 Apr 2016 16:39:19 +0100
Subject: [PATCH v3 2/2] arm64: dts: Add expansion bus to Juno
In-Reply-To: <1460648359-7310-1-git-send-email-brian.starkey@arm.com>
References: <1460648359-7310-1-git-send-email-brian.starkey@arm.com>
Message-ID: <1460648359-7310-2-git-send-email-brian.starkey@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Juno development platform has an external expansion bus which can
be used for additional hardware (e.g. LogicTile Express daughterboards).
Add this bus to the Juno base device-tree.

Signed-off-by: Brian Starkey <brian.starkey@arm.com>
Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>
---
 arch/arm64/boot/dts/arm/juno-base.dtsi |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
index 68ccc39..dee2386 100644
--- a/arch/arm64/boot/dts/arm/juno-base.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
@@ -272,3 +272,13 @@
 
 		/include/ "juno-motherboard.dtsi"
 	};
+
+	site2: tlx at 60000000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0 0x60000000 0x10000000>;
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0>;
+		interrupt-map = <0 0 &gic 0 0 0 168 IRQ_TYPE_LEVEL_HIGH>;
+	};
-- 
1.7.9.5
