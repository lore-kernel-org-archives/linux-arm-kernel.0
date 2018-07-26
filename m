From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Thu, 26 Jul 2018 09:19:54 +0200
Subject: [PATCH 2/4] ARM: dts: stm32: Remove cd-inverted property for
 stm32f469-disco
In-Reply-To: <1532589596-22181-1-git-send-email-patrice.chotard@st.com>
References: <1532589596-22181-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1532589596-22181-3-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

Remove cd-inverted property and update cd-gpios active level
accordingly

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 arch/arm/boot/dts/stm32f469-disco.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/stm32f469-disco.dts b/arch/arm/boot/dts/stm32f469-disco.dts
index 3ee768cb86fc..7937b43d7788 100644
--- a/arch/arm/boot/dts/stm32f469-disco.dts
+++ b/arch/arm/boot/dts/stm32f469-disco.dts
@@ -210,8 +210,7 @@
 &sdio {
 	status = "okay";
 	vmmc-supply = <&mmc_vcard>;
-	cd-gpios = <&gpiog 2 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&gpiog 2 GPIO_ACTIVE_LOW>;
 	broken-cd;
 	pinctrl-names = "default", "opendrain";
 	pinctrl-0 = <&sdio_pins>;
-- 
1.9.1
