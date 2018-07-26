From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Thu, 26 Jul 2018 09:19:53 +0200
Subject: [PATCH 1/4] ARM: dts: stm32: Remove cd-inverted property for
 stm32429i-eval
In-Reply-To: <1532589596-22181-1-git-send-email-patrice.chotard@st.com>
References: <1532589596-22181-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1532589596-22181-2-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

Remove cd-inverted property and update cd-gpios active level
accordingly

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 arch/arm/boot/dts/stm32429i-eval.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
index 7eb786a2d624..ed7d7f46465e 100644
--- a/arch/arm/boot/dts/stm32429i-eval.dts
+++ b/arch/arm/boot/dts/stm32429i-eval.dts
@@ -264,8 +264,7 @@
 &sdio {
 	status = "okay";
 	vmmc-supply = <&mmc_vcard>;
-	cd-gpios = <&stmpegpio 15 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&stmpegpio 15 GPIO_ACTIVE_LOW>;
 	pinctrl-names = "default", "opendrain";
 	pinctrl-0 = <&sdio_pins>;
 	pinctrl-1 = <&sdio_pins_od>;
-- 
1.9.1
