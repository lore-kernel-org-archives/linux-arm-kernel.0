From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 14 Mar 2013 13:09:01 +0100
Subject: [PATCH 6/7] ARM: i.MX6: Add clocks to GPT devicetree node
In-Reply-To: <1363262942-26702-1-git-send-email-s.hauer@pengutronix.de>
References: <1363262942-26702-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1363262942-26702-7-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX6 already has a devicetree node for the GPT, but not yet
has the clocks. Add them.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl.dtsip | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsip b/arch/arm/boot/dts/imx6qdl.dtsip
index 52b156f..aa92d43 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsip
+++ b/arch/arm/boot/dts/imx6qdl.dtsip
@@ -282,6 +282,8 @@
 				compatible = "fsl,imx6q-gpt";
 				reg = <0x02098000 0x4000>;
 				interrupts = <0 55 0x04>;
+				clocks = <&clks 119>, <&clks 120>;
+				clock-names = "ipg", "per";
 			};
 
 			gpio1: gpio at 0209c000 {
-- 
1.8.2.rc2
