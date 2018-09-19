From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Wed, 19 Sep 2018 15:27:49 +0200
Subject: [PATCH v2 7/7] ARM: dts: stm32: add orange and blue leds on
 stm32746g-eval
In-Reply-To: <1537363669-25991-1-git-send-email-amelie.delaunay@st.com>
References: <1537363669-25991-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1537363669-25991-8-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Orange (LD2) and blue (LD4) leds on stm32746g-eval are connected on
STMFX gpio expander, offset 17 and 19.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32746g-eval.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/stm32746g-eval.dts b/arch/arm/boot/dts/stm32746g-eval.dts
index b86ad83..a5fa73f 100644
--- a/arch/arm/boot/dts/stm32746g-eval.dts
+++ b/arch/arm/boot/dts/stm32746g-eval.dts
@@ -69,9 +69,15 @@
 			gpios = <&gpiof 10 1>;
 			linux,default-trigger = "heartbeat";
 		};
+		orange {
+			gpios = <&stmfx_pinctrl 17 1>;
+		};
 		red {
 			gpios = <&gpiob 7 1>;
 		};
+		blue {
+			gpios = <&stmfx_pinctrl 19 1>;
+		};
 	};
 
 	gpio_keys {
-- 
2.7.4
