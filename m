From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 16 Jun 2015 14:31:51 -0700
Subject: [PATCH 08/10] ARM: dts: qcom: msm8660-surf: Use stdout-path
In-Reply-To: <1434490313-13905-1-git-send-email-sboyd@codeaurora.org>
References: <1434490313-13905-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1434490313-13905-9-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use stdout-path so that we don't have to put the console on the
kernel command line.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/boot/dts/qcom-msm8660-surf.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8660-surf.dts b/arch/arm/boot/dts/qcom-msm8660-surf.dts
index e0883c376248..b17f379e8c2a 100644
--- a/arch/arm/boot/dts/qcom-msm8660-surf.dts
+++ b/arch/arm/boot/dts/qcom-msm8660-surf.dts
@@ -6,6 +6,14 @@
 	model = "Qualcomm MSM8660 SURF";
 	compatible = "qcom,msm8660-surf", "qcom,msm8660";
 
+	aliases {
+		serial0 = &gsbi12_serial;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
 	soc {
 		gsbi at 19c00000 {
 			status = "ok";
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
