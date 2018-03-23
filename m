From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Fri, 23 Mar 2018 14:04:50 +0100
Subject: [PATCH v4 3/8] ARM: davinci: dts: add a reset control to the dsp node
In-Reply-To: <20180323130455.11470-1-brgl@bgdev.pl>
References: <20180323130455.11470-1-brgl@bgdev.pl>
Message-ID: <20180323130455.11470-4-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The davinci-rproc driver will soon use the reset framework. Add the
resets property to the dsp node in da850.dtsi.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index dad64dbf1f23..5b485e44b83e 100644
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
2.16.1
