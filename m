From: mathieu@codeaurora.org (Mathieu Olivari)
Date: Tue, 18 Aug 2015 15:05:38 -0700
Subject: [PATCH 2/2] ARM: qcom: enable uart output by default on AP148
In-Reply-To: <1439935538-13932-1-git-send-email-mathieu@codeaurora.org>
References: <1439935538-13932-1-git-send-email-mathieu@codeaurora.org>
Message-ID: <1439935538-13932-3-git-send-email-mathieu@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This change adds a new chosen node to boot using UART console on AP148

Signed-off-by: Mathieu Olivari <mathieu@codeaurora.org>
---
 arch/arm/boot/dts/qcom-ipq8064-ap148.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064-ap148.dts b/arch/arm/boot/dts/qcom-ipq8064-ap148.dts
index 55b2910..b08907a 100644
--- a/arch/arm/boot/dts/qcom-ipq8064-ap148.dts
+++ b/arch/arm/boot/dts/qcom-ipq8064-ap148.dts
@@ -14,6 +14,14 @@
 		};
 	};
 
+	alias {
+		serial0 = &uart4;
+	};
+
+	chosen {
+		linux,stdout-path = "serial0:115200n8";
+	};
+
 	soc {
 		pinmux at 800000 {
 			i2c4_pins: i2c4_pinmux {
-- 
2.1.4
