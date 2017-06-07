From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed,  7 Jun 2017 11:08:22 +0200
Subject: [PATCH 3/3] arm64: dts: hikey: Add external clock to the Bluetooth
 node
In-Reply-To: <1496826502-1339-1-git-send-email-ulf.hansson@linaro.org>
References: <1496826502-1339-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1496826502-1339-4-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To make the TI WiLink chip work again for Bluetooth, let's add the missing
external clock to the Bluetooth node, such the driver can deal properly
with it during power on/off.

Fixes: ea452678734e ("arm64: dts: hikey: Fix WiFi support")
Cc: Wei Xu <xuwei5@hisilicon.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index 49f6a62..5cdfe73 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -141,6 +141,8 @@
 			bluetooth {
 				compatible = "ti,wl1835-st";
 				enable-gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
+				clocks = <&pmic>;
+				clock-names = "ext_clock";
 			};
 		};
 
-- 
2.7.4
