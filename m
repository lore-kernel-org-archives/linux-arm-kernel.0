From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Fri, 16 Nov 2018 13:20:21 +0100
Subject: [PATCH v1 1/2] dt-bindings: i2c-stm32: SYSCFG Fast Mode Plus support
 for I2C STM32F7
In-Reply-To: <1542370822-14721-1-git-send-email-pierre-yves.mordret@st.com>
References: <1542370822-14721-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <1542370822-14721-2-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Append optional bindings to update SYSCFG Fast Mode Plus bits if
Fast Mode Plus speed is selected.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
    v1:
       * Initial
---
---
 Documentation/devicetree/bindings/i2c/i2c-stm32.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-stm32.txt b/Documentation/devicetree/bindings/i2c/i2c-stm32.txt
index 3b54899..69240e1 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-stm32.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-stm32.txt
@@ -26,6 +26,11 @@ Optional properties :
 - i2c-scl-falling-time-ns : Only for STM32F7, I2C SCL Falling time for the board
   (default: 10)
   I2C Timings are derived from these 2 values
+- st,syscfg-fmp:  Only for STM32F7, use to set Fast Mode Plus bit within SYSCFG
+  whether Fast Mode Plus speed is selected by slave.
+	1st cell : phandle to syscfg
+	2nd cell : register offset within SYSCFG
+	3rd cell : register bitmask for FMP bit
 
 Example :
 
@@ -53,4 +58,5 @@ Example :
 		clocks = <&rcc 1 CLK_I2C1>;
 		pinctrl-0 = <&i2c1_sda_pin>, <&i2c1_scl_pin>;
 		pinctrl-names = "default";
+		st,syscfg-fmp = <&syscfg 0x4 0x1>;
 	};
-- 
2.7.4
