From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 12 May 2015 13:51:41 +0100
Subject: [PATCH 04/13] ARM: STi: STiH416-b2020e: Enable PWM on the B2020 Rev-E
In-Reply-To: <1431435110-22595-1-git-send-email-lee.jones@linaro.org>
References: <1431435110-22595-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1431435110-22595-5-git-send-email-lee.jones@linaro.org>
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
index 961799e..f1ceee1 100644
--- a/arch/arm/boot/dts/stih416-b2020e.dts
+++ b/arch/arm/boot/dts/stih416-b2020e.dts
@@ -51,5 +51,15 @@
 		sata0: sata at fe380000{
 			status = "okay";
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
1.9.1
