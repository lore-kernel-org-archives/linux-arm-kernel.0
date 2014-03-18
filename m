From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Tue, 18 Mar 2014 16:00:05 +0100
Subject: [PATCH v2 4/5] ARM: STi: DT: add keyscan for stih41x-b2000
In-Reply-To: <1395154806-2810-1-git-send-email-gabriel.fernandez@st.com>
References: <1395154806-2810-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1395154806-2810-5-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add keyscan setup for stih415/h416 b2000.
Both have same raw/column lines number, debounce time and keymap.

Signed-off-by: Giuseppe Condorelli <giuseppe.condorelli@st.com>
Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 arch/arm/boot/dts/stih41x-b2000.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/stih41x-b2000.dtsi b/arch/arm/boot/dts/stih41x-b2000.dtsi
index 1e6aa92..c5f2191 100644
--- a/arch/arm/boot/dts/stih41x-b2000.dtsi
+++ b/arch/arm/boot/dts/stih41x-b2000.dtsi
@@ -6,6 +6,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * publishhed by the Free Software Foundation.
  */
+#include <dt-bindings/input/input.h>
 / {
 
 	memory{
@@ -46,5 +47,27 @@
 
 			status = "okay";
 		};
+
+		keyscan: keyscan at fe4b0000 {
+			keypad,num-rows = <4>;
+			keypad,num-columns = <4>;
+			st,debounce_us = <5000>;
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
1.9.0
