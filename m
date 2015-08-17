From: mathieu@codeaurora.org (Mathieu Olivari)
Date: Mon, 17 Aug 2015 16:47:44 -0700
Subject: [PATCH v3 1/3] ARM: qcom: add SFPB nodes to IPQ806x dts
In-Reply-To: <1439855266-26242-1-git-send-email-mathieu@codeaurora.org>
References: <1439855266-26242-1-git-send-email-mathieu@codeaurora.org>
Message-ID: <1439855266-26242-2-git-send-email-mathieu@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add one new node to the ipq806x.dtsi file to declare & register the
hardware spinlock devices. This mechanism is required to be used by
other drivers such as SMEM.

Signed-off-by: Mathieu Olivari <mathieu@codeaurora.org>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 9f727d8..8d366ae 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -329,5 +329,16 @@
 			#reset-cells = <1>;
 		};
 
+		sfpb_mutex_block: syscon at 1200600 {
+			compatible = "syscon";
+			reg = <0x01200600 0x100>;
+		};
+	};
+
+	sfpb_mutex: sfpb-mutex {
+		compatible = "qcom,sfpb-mutex";
+		syscon = <&sfpb_mutex_block 4 4>;
+
+		#hwlock-cells = <1>;
 	};
 };
-- 
2.1.4
