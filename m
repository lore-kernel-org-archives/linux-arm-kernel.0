From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 16 Jun 2015 14:31:48 -0700
Subject: [PATCH 05/10] ARM: dts: qcom: apq8084-ifc6540: Use stdout-path
In-Reply-To: <1434490313-13905-1-git-send-email-sboyd@codeaurora.org>
References: <1434490313-13905-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1434490313-13905-6-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use stdout-path so that we don't have to put the console on the
kernel command line.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/boot/dts/qcom-apq8084-ifc6540.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8084-ifc6540.dts b/arch/arm/boot/dts/qcom-apq8084-ifc6540.dts
index f7725b96612c..c9c2b769554f 100644
--- a/arch/arm/boot/dts/qcom-apq8084-ifc6540.dts
+++ b/arch/arm/boot/dts/qcom-apq8084-ifc6540.dts
@@ -5,6 +5,14 @@
 	model = "Qualcomm APQ8084/IFC6540";
 	compatible = "qcom,apq8084-ifc6540", "qcom,apq8084";
 
+	aliases {
+		serial0 = &blsp2_uart2;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
 	soc {
 		serial at f995e000 {
 			status = "okay";
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
