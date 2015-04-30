From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 30 Apr 2015 14:30:52 +0100
Subject: [PATCH v3 6/6] ARM: DT: STi: STiH418: Enable USB3 port on
 stih418-b2199.
In-Reply-To: <1430400652-3366-1-git-send-email-peter.griffin@linaro.org>
References: <1430400652-3366-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1430400652-3366-7-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The USB3 controller is present on the b2199 board, so enable
it in the board specific DT file.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm/boot/dts/stih418-b2199.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/stih418-b2199.dts b/arch/arm/boot/dts/stih418-b2199.dts
index e0e5b23..5e59b46 100644
--- a/arch/arm/boot/dts/stih418-b2199.dts
+++ b/arch/arm/boot/dts/stih418-b2199.dts
@@ -85,5 +85,9 @@
 				st,osc-force-ext;
 			};
 		};
+
+		st_dwc3: dwc3 at 8f94000 {
+			status = "okay";
+		};
 	};
 };
-- 
1.9.1
