From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 14 Jul 2014 15:33:25 +0100
Subject: [PATCH v2 04/11] ARM: stih416-b2020e: Enable PWM on the B2020 Rev-E
In-Reply-To: <1405348412-7352-1-git-send-email-lee.jones@linaro.org>
References: <1405348412-7352-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1405348412-7352-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All the infrastructure is now in place for ST's PWM controller.  This
patch takes the final step and enables the IP on the 2020 Rev-E
development platform.

Signed-off-by: Ajit Pal Singh <ajitpal.singh@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih416-b2020e.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/stih416-b2020e.dts b/arch/arm/boot/dts/stih416-b2020e.dts
index ba0fa2c..07cbf5b 100644
--- a/arch/arm/boot/dts/stih416-b2020e.dts
+++ b/arch/arm/boot/dts/stih416-b2020e.dts
@@ -31,5 +31,15 @@
 		ethernet1: dwmac at fef08000 {
 			snps,reset-gpio = <&PIO0 7>;
 		};
+
+		/* SAS PWM Module */
+		pwm0: pwm at fed10000 {
+			status		= "okay";
+		};
+
+		/* SBC PWM Module */
+		pwm1: pwm at fe510000 {
+			status		= "okay";
+		};
 	};
 };
-- 
1.8.3.2
