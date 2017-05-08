From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon,  8 May 2017 18:21:13 +0200
Subject: [PATCH 4/8] arm64: dts: hikey: Add clock for the pmic mfd
In-Reply-To: <1494260477-25163-1-git-send-email-ulf.hansson@linaro.org>
References: <1494260477-25163-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1494260477-25163-5-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Daniel Lezcano <daniel.lezcano@linaro.org>

The hi655x PMIC provides the regulators but also a clock. The latter is
missing so let's add it. This clock is used by WiFi/Bluetooth chip, but
that connection is done in a separate change on top of this one.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
[Ulf: Split patch and updated changelog]
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index dba3c13..e0496f7 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -325,6 +325,7 @@
 	pmic: pmic at f8000000 {
 		compatible = "hisilicon,hi655x-pmic";
 		reg = <0x0 0xf8000000 0x0 0x1000>;
+		#clock-cells = <0>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 		pmic-gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
-- 
2.7.4
