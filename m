From: ludovic.Barre@st.com (Ludovic Barre)
Date: Wed, 25 Oct 2017 19:11:04 +0200
Subject: [PATCH v2 8/9] ARM: dts: stm32: add system config bank node for
 stm32h743
In-Reply-To: <1508951465-17152-1-git-send-email-ludovic.Barre@st.com>
References: <1508951465-17152-1-git-send-email-ludovic.Barre@st.com>
Message-ID: <1508951465-17152-9-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds system config support for stm32h743.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 arch/arm/boot/dts/stm32h743.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
index 6b2fb4c..b17aa5c 100644
--- a/arch/arm/boot/dts/stm32h743.dtsi
+++ b/arch/arm/boot/dts/stm32h743.dtsi
@@ -194,6 +194,11 @@
 			};
 		};
 
+		syscfg: system-config at 58000400 {
+			compatible = "syscon";
+			reg = <0x58000400 0x400>;
+		};
+
 		exti: interrupt-controller at 58000000 {
 			compatible = "st,stm32h7-exti";
 			interrupt-controller;
-- 
2.7.4
