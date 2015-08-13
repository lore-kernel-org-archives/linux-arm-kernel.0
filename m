From: mathieu@codeaurora.org (Mathieu Olivari)
Date: Thu, 13 Aug 2015 14:33:39 -0700
Subject: [PATCH 2/3] ARM: qcom: add SMEM device node to IPQ806x dts
In-Reply-To: <1439501620-24073-1-git-send-email-mathieu@codeaurora.org>
References: <1439501620-24073-1-git-send-email-mathieu@codeaurora.org>
Message-ID: <1439501620-24073-3-git-send-email-mathieu@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SMEM is used on IPQ806x to store various board related information such
as boot device and flash partition layout. We'll declare it as a device
so we can make use of it thanks to the new SMEM soc driver.

Signed-off-by: Mathieu Olivari <mathieu@codeaurora.org>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index ea7b959..9ee9780 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -55,7 +55,7 @@
 			no-map;
 		};
 
-		smem at 41000000 {
+		smem: smem at 41000000 {
 			reg = <0x41000000 0x200000>;
 			no-map;
 		};
@@ -79,6 +79,15 @@
 
 			#hwlock-cells = <1>;
 		};
+
+		smem {
+			compatible = "qcom,smem";
+
+			memory-region = <&smem>;
+			reg = <0x41000000 0x4000>;
+
+			hwlocks = <&sfpb_mutex 3>;
+		};
 	};
 
 	soc: soc {
-- 
2.1.4
