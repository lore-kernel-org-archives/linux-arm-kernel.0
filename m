From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Thu, 21 Jun 2018 09:37:06 +0200
Subject: [PATCH v7 4/4] ARM: davinci: dts: add a reset control to the dsp node
In-Reply-To: <20180621073706.22812-1-brgl@bgdev.pl>
References: <20180621073706.22812-1-brgl@bgdev.pl>
Message-ID: <20180621073706.22812-5-brgl@bgdev.pl>
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
index 1bc0e4bc0697..225e0cf4b7bc 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -118,6 +118,7 @@
 		interrupt-parent = <&intc>;
 		interrupts = <28>;
 		clocks = <&psc0 15>;
+		resets = <&psc0 15>;
 		status = "disabled";
 	};
 	soc at 1c00000 {
-- 
2.17.1
