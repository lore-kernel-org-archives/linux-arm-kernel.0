From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 17 Oct 2013 14:31:28 -0700
Subject: [PATCH 2/3] ARM: dts: MSM8974: Add restart node
In-Reply-To: <1382045489-21075-1-git-send-email-sboyd@codeaurora.org>
References: <1382034310-31147-1-git-send-email-rvaswani@codeaurora.org>
 <1382045489-21075-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1382045489-21075-3-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the restart node so we can reboot the device.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 2ebb4f0..5ac7701 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -30,4 +30,9 @@
 			clock-frequency = <19200000>;
 		};
 	};
+
+	restart at fc4ab000 {
+		compatible = "qcom,pshold";
+		reg = <0xfc4ab000 0x4>;
+	};
 };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
