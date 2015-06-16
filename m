From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 16 Jun 2015 14:31:53 -0700
Subject: [PATCH 10/10] ARM: dts: qcom: msm8974-sony-xperia-honami: Use
 stdout-path
In-Reply-To: <1434490313-13905-1-git-send-email-sboyd@codeaurora.org>
References: <1434490313-13905-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1434490313-13905-11-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use stdout-path so that we don't have to put the console on the
kernel command line.

Cc: Tim Bird <tim.bird@sonymobile.com>
Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
index bd35b0674ff6..eb547f1f6a60 100644
--- a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
@@ -6,6 +6,14 @@
 	model = "Sony Xperia Z1";
 	compatible = "sony,xperia-honami", "qcom,msm8974";
 
+	aliases {
+		serial0 = &blsp1_uart2;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
 	memory at 0 {
 		reg = <0 0x40000000>, <0x40000000 0x40000000>;
 		device_type = "memory";
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
