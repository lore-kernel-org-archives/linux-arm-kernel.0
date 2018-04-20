From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Fri, 20 Apr 2018 11:05:10 +0200
Subject: [PATCH v1 3/3] ARM: dts: stm32: Add I2C1 support for STM32F746-DISCO
 Board
In-Reply-To: <1524215110-13967-1-git-send-email-pierre-yves.mordret@st.com>
References: <1524215110-13967-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <1524215110-13967-4-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add I2C1 support for STM32F746-DISCO Board

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
     v1:
        * Initial
---
---
 arch/arm/boot/dts/stm32f746-disco.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f746-disco.dts b/arch/arm/boot/dts/stm32f746-disco.dts
index be94c6a..f9ad71f 100644
--- a/arch/arm/boot/dts/stm32f746-disco.dts
+++ b/arch/arm/boot/dts/stm32f746-disco.dts
@@ -90,6 +90,14 @@
 	clock-frequency = <25000000>;
 };
 
+&i2c1 {
+	pinctrl-0 = <&i2c1_pins_b>;
+	pinctrl-names = "default";
+	i2c-scl-rising-time-ns = <185>;
+	i2c-scl-falling-time-ns = <20>;
+	status = "okay";
+};
+
 &sdio1 {
 	status = "okay";
 	vmmc-supply = <&mmc_vcard>;
-- 
2.7.4
