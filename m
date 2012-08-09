From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  9 Aug 2012 16:47:38 +0100
Subject: [PATCH 12/22] ARM: ux500: Add AB8500 CODEC node to DB8500 Device Tree
In-Reply-To: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1344527268-5964-13-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ensure correct probing and pass though important configuration
options to the AB8500 CODEC driver when DT is enabled

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/db8500.dtsi |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/db8500.dtsi b/arch/arm/boot/dts/db8500.dtsi
index 33fafe3..83ed692 100644
--- a/arch/arm/boot/dts/db8500.dtsi
+++ b/arch/arm/boot/dts/db8500.dtsi
@@ -389,6 +389,12 @@
 					compatible = "stericsson,ab8500-debug";
 				};
 
+				codec: ab8500-codec {
+					compatible = "stericsson,ab8500-codec";
+
+					stericsson,earpeice-cmv = <950>; /* Units in mV. */
+				};
+
 				ab8500-regulators {
 					compatible = "stericsson,ab8500-regulator";
 
-- 
1.7.9.5
