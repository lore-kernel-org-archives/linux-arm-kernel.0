From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Thu, 20 Sep 2018 18:34:16 +0200
Subject: [PATCH 1/2] ARM: dts: stm32: update SPI6 dmas property on stm32mp157c
In-Reply-To: <1537461257-2940-1-git-send-email-alexandre.torgue@st.com>
References: <1537461257-2940-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <1537461257-2940-2-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Amelie Delaunay <amelie.delaunay@st.com>

Remove unused parameter from SPI6 dmas property on stm32mp157c SoC.

Fixes: dc3f8c86c10d ("ARM: dts: stm32: add SPI support on stm32mp157c")
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index 661be94..185541a 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -1078,8 +1078,8 @@
 			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&rcc SPI6_K>;
 			resets = <&rcc SPI6_R>;
-			dmas = <&mdma1 34 0x0 0x40008 0x0 0x0 0>,
-			       <&mdma1 35 0x0 0x40002 0x0 0x0 0>;
+			dmas = <&mdma1 34 0x0 0x40008 0x0 0x0>,
+			       <&mdma1 35 0x0 0x40002 0x0 0x0>;
 			dma-names = "rx", "tx";
 			status = "disabled";
 		};
-- 
2.7.4
