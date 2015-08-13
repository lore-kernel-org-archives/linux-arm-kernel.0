From: mathieu@codeaurora.org (Mathieu Olivari)
Date: Thu, 13 Aug 2015 14:33:38 -0700
Subject: [PATCH 1/3] ARM: qcom: add SFPB nodes to IPQ806x dts
In-Reply-To: <1439501620-24073-1-git-send-email-mathieu@codeaurora.org>
References: <1439501620-24073-1-git-send-email-mathieu@codeaurora.org>
Message-ID: <1439501620-24073-2-git-send-email-mathieu@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add one new node to the ipq806x.dtsi file to declare & register the
hardware spinlock devices. This mechanism is required to be used by
other drivers such as SMEM.

Signed-off-by: Mathieu Olivari <mathieu@codeaurora.org>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 9f727d8..ea7b959 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -67,6 +67,18 @@
 			clock-frequency = <32768>;
 			#clock-cells = <0>;
 		};
+
+		sfpb_mutex_block: syscon at 01200600 {
+			compatible = "syscon";
+			reg = <0x01200600 0x100>;
+		};
+
+		sfpb_mutex: sfpb-mutex {
+			compatible = "qcom,sfpb-mutex";
+			syscon = <&sfpb_mutex_block 4 4>;
+
+			#hwlock-cells = <1>;
+		};
 	};
 
 	soc: soc {
-- 
2.1.4
