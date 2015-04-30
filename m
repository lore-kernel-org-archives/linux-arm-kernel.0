From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 30 Apr 2015 14:30:50 +0100
Subject: [PATCH v3 4/6] ARM: DT: STi: stihxxx-b2120: Enable USB3 port on
 stih407-b2120 and stih410-b2120
In-Reply-To: <1430400652-3366-1-git-send-email-peter.griffin@linaro.org>
References: <1430400652-3366-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1430400652-3366-5-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The USB3 controller is present on both variants of the b2120 board so
enable the controller in the generic stihxxx-b2120.dtsi file.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm/boot/dts/stihxxx-b2120.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/stihxxx-b2120.dtsi b/arch/arm/boot/dts/stihxxx-b2120.dtsi
index c1d8590..bef9128 100644
--- a/arch/arm/boot/dts/stihxxx-b2120.dtsi
+++ b/arch/arm/boot/dts/stihxxx-b2120.dtsi
@@ -66,5 +66,10 @@
 				st,osc-force-ext;
 			};
 		};
+
+		st_dwc3: dwc3 at 8f94000 {
+			status = "okay";
+		};
+
 	};
 };
-- 
1.9.1
