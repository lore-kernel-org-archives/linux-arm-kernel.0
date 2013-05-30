From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Thu, 30 May 2013 15:27:43 +0200
Subject: [PATCH 3/5] ARM: ux500: Add DT regulators for ab8500-codec
In-Reply-To: <1369920465-13905-1-git-send-email-fabio.baltieri@linaro.org>
References: <1369920465-13905-1-git-send-email-fabio.baltieri@linaro.org>
Message-ID: <1369920465-13905-4-git-send-email-fabio.baltieri@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add regulator DT bindings for the ab8500-codec driver.

Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index d0b6e32..8e14042 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -410,6 +410,11 @@
 				codec: ab8500-codec {
 					compatible = "stericsson,ab8500-codec";
 
+					V-AUD-supply = <&ab8500_ldo_audio_reg>;
+					V-AMIC1-supply = <&ab8500_ldo_anamic1_reg>;
+					V-AMIC2-supply = <&ab8500_ldo_anamic2_reg>;
+					V-DMIC-supply = <&ab8500_ldo_dmic_reg>;
+
 					stericsson,earpeice-cmv = <950>; /* Units in mV. */
 				};
 
-- 
1.8.2
