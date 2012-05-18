From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 18 May 2012 09:39:09 +0100
Subject: [PATCH 10/16] ARM: ux500: Add db8500 Device Tree node for
 ab8500-sysctrl
In-Reply-To: <1337330355-17747-1-git-send-email-lee.jones@linaro.org>
References: <1337330355-17747-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1337330355-17747-11-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the DT node for the mfd/ab8500-sysctrl driver. It will
allow probing of the driver during a Device Tree enabled boot.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/db8500.dtsi |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/db8500.dtsi b/arch/arm/boot/dts/db8500.dtsi
index 5e78899..3c00e0670 100644
--- a/arch/arm/boot/dts/db8500.dtsi
+++ b/arch/arm/boot/dts/db8500.dtsi
@@ -329,6 +329,10 @@
 					interrupt-names = "ONKEY_DBF", "ONKEY_DBR";
 				};
 
+				ab8500-sysctrl {
+					compatible = "stericsson,ab8500-sysctrl";
+				};
+
 				ab8500-regulators {
 					compatible = "stericsson,ab8500-regulator";
 
-- 
1.7.9.5
