From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Tue, 17 Apr 2018 19:30:33 +0200
Subject: [PATCH v6 2/7] ARM: davinci: dts: add a reset control to the dsp node
In-Reply-To: <20180417173038.25510-1-brgl@bgdev.pl>
References: <20180417173038.25510-1-brgl@bgdev.pl>
Message-ID: <20180417173038.25510-3-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The davinci-rproc driver will soon use the reset framework. Add the
resets property to the dsp node in da850.dtsi.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/boot/dts/da850.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index d56e670d9a32..250aeee53202 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -109,6 +109,7 @@
 		interrupt-parent = <&intc>;
 		interrupts = <28>;
 		clocks = <&psc0 15>;
+		resets = <&psc0 15>;
 		status = "disabled";
 	};
 	soc at 1c00000 {
-- 
2.17.0
