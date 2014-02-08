From: carlo@caione.org (Carlo Caione)
Date: Sat,  8 Feb 2014 17:05:54 +0100
Subject: [PATCH 2/2] input: misc: dts: Add axp20x-pek node to axp20x.dtsi
In-Reply-To: <1391875554-6383-1-git-send-email-carlo@caione.org>
References: <1391875554-6383-1-git-send-email-carlo@caione.org>
Message-ID: <1391875554-6383-3-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a sub-node to axp20x.dtsi

Signed-off-by: Carlo Caione <carlo@caione.org>
---
 arch/arm/boot/dts/axp20x.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/axp20x.dtsi b/arch/arm/boot/dts/axp20x.dtsi
index 98d4c7c..3d475e2 100644
--- a/arch/arm/boot/dts/axp20x.dtsi
+++ b/arch/arm/boot/dts/axp20x.dtsi
@@ -6,4 +6,10 @@
 	compatible = "x-powers,axp20x";
 	interrupt-controller;
 	#interrupt-cells = <1>;
+
+	axp20x-pek {
+		compatible = "x-powers,axp20x-pek";
+		interrupts = <33>,  <34>;
+		interrupt-names = "PEK_DBR", "PEK_DBF";
+	};
 };
-- 
1.8.5.3
