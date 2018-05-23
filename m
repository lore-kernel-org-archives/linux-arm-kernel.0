From: christophe.roullier@st.com (Christophe Roullier)
Date: Wed, 23 May 2018 17:47:55 +0200
Subject: [PATCH V4 4/8] ARM: dts: stm32: Add syscfg on stm32mp1
In-Reply-To: <1527090479-5263-1-git-send-email-christophe.roullier@st.com>
References: <1527090479-5263-1-git-send-email-christophe.roullier@st.com>
Message-ID: <1527090479-5263-5-git-send-email-christophe.roullier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

System configuration controller is mainly used to manage
the compensation cell and other IOs and system related
settings.

Signed-off-by: Christophe Roullier <christophe.roullier@st.com>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index bc3eddc..3db03a2 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -167,6 +167,11 @@
 			#reset-cells = <1>;
 		};
 
+		syscfg: syscon at 50020000 {
+			compatible = "st,stm32mp157-syscfg", "syscon";
+			reg = <0x50020000 0x400>;
+		};
+
 		usart1: serial at 5c000000 {
 			compatible = "st,stm32h7-uart";
 			reg = <0x5c000000 0x400>;
-- 
1.9.1
