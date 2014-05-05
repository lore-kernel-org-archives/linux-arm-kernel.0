From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Mon,  5 May 2014 17:38:39 +0200
Subject: [PATCH 3/4] ARM: STi: DT: add keyscan for stih41x-b2000
In-Reply-To: <1399304320-18197-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1399304320-18197-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1399304320-18197-4-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add keyscan setup for stih415/h416 b2000.
Both have same raw/column lines number, debounce time and keymap.

Signed-off-by: Giuseppe Condorelli <giuseppe.condorelli@st.com>
Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
---
 arch/arm/boot/dts/stih41x-b2000.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/stih41x-b2000.dtsi b/arch/arm/boot/dts/stih41x-b2000.dtsi
index bf65c49..403bf1b 100644
--- a/arch/arm/boot/dts/stih41x-b2000.dtsi
+++ b/arch/arm/boot/dts/stih41x-b2000.dtsi
@@ -6,6 +6,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * publishhed by the Free Software Foundation.
  */
+#include <dt-bindings/input/input.h>
 / {
 
 	memory{
@@ -68,5 +69,27 @@
 			snps,reset-active-low;
 			snps,reset-delays-us 	= <0 10000 10000>;
 		};
+
+		keyscan: keyscan at fe4b0000 {
+			keypad,num-rows = <4>;
+			keypad,num-columns = <4>;
+			st,debounce-us = <5000>;
+			linux,keymap = < MATRIX_KEY(0x00, 0x00, KEY_F13)
+					 MATRIX_KEY(0x00, 0x01, KEY_F9)
+					 MATRIX_KEY(0x00, 0x02, KEY_F5)
+					 MATRIX_KEY(0x00, 0x03, KEY_F1)
+					 MATRIX_KEY(0x01, 0x00, KEY_F14)
+					 MATRIX_KEY(0x01, 0x01, KEY_F10)
+					 MATRIX_KEY(0x01, 0x02, KEY_F6)
+					 MATRIX_KEY(0x01, 0x03, KEY_F2)
+					 MATRIX_KEY(0x02, 0x00, KEY_F15)
+					 MATRIX_KEY(0x02, 0x01, KEY_F11)
+					 MATRIX_KEY(0x02, 0x02, KEY_F7)
+					 MATRIX_KEY(0x02, 0x03, KEY_F3)
+					 MATRIX_KEY(0x03, 0x00, KEY_F16)
+					 MATRIX_KEY(0x03, 0x01, KEY_F12)
+					 MATRIX_KEY(0x03, 0x02, KEY_F8)
+					 MATRIX_KEY(0x03, 0x03, KEY_F4) >;
+		};
 	};
 };
-- 
1.9.1
