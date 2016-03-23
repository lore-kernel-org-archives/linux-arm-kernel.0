From: mmcclint@codeaurora.org (Matthew McClintock)
Date: Wed, 23 Mar 2016 17:05:06 -0500
Subject: [PATCH 11/17] qcom: ipq4019: add support for reset via qcom,ps-hold
In-Reply-To: <1458770712-10880-1-git-send-email-mmcclint@codeaurora.org>
References: <1458770712-10880-1-git-send-email-mmcclint@codeaurora.org>
Message-ID: <1458770712-10880-12-git-send-email-mmcclint@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will allow these types of boards to be rebooted.

Signed-off-by: Matthew McClintock <mmcclint@codeaurora.org>
---
 arch/arm/boot/dts/qcom-ipq4019.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index 00a5e9e..acb851d 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -179,5 +179,10 @@
 			timeout-sec = <10>;
 			status = "disabled";
 		};
+
+		restart at 4ab000 {
+			compatible = "qcom,pshold";
+			reg = <0x4ab000 0x4>;
+		};
 	};
 };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
