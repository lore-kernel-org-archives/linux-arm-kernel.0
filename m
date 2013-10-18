From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 18 Oct 2013 10:56:44 -0700
Subject: [PATCH v2 2/4] ARM: dts: MSM8974: Add restart node
In-Reply-To: <1382119006-22231-1-git-send-email-sboyd@codeaurora.org>
References: <1382034310-31147-1-git-send-email-rvaswani@codeaurora.org>
 <1382119006-22231-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1382119006-22231-3-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the restart node so we can reboot the device.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 2ebb4f0..df18637 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -29,5 +29,10 @@
 				     <1 1 0xf08>;
 			clock-frequency = <19200000>;
 		};
+
+		restart at fc4ab000 {
+			compatible = "qcom,pshold";
+			reg = <0xfc4ab000 0x4>;
+		};
 	};
 };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
