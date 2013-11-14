From: tim.kryger@linaro.org (Tim Kryger)
Date: Thu, 14 Nov 2013 11:10:38 -0800
Subject: [PATCH v3 3/8] Documentation: dt: kona-sdhci: Add clocks
 property
In-Reply-To: <1384456243-27053-1-git-send-email-tim.kryger@linaro.org>
References: <1384456243-27053-1-git-send-email-tim.kryger@linaro.org>
Message-ID: <1384456243-27053-4-git-send-email-tim.kryger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Kona SDHCI block requires a clock that must be specified in the
device tree.  Update the documentation to reflect this requirement.

Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
Reviewed-by: Matt Porter <matt.porter@linaro.org>
---
 Documentation/devicetree/bindings/mmc/kona-sdhci.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/kona-sdhci.txt b/Documentation/devicetree/bindings/mmc/kona-sdhci.txt
index 789fb07..42a57c6 100644
--- a/Documentation/devicetree/bindings/mmc/kona-sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/kona-sdhci.txt
@@ -6,12 +6,17 @@ and the properties present in the bcm281xx SDHCI
 Required properties:
 - compatible : Should be "brcm,kona-sdhci"
 - DEPRECATED: compatible : Should be "bcm,kona-sdhci"
+- clocks: clock specifier for the kona i2c external clock
+
+Refer to clocks/clock-bindings.txt for generic clock consumer
+properties.
 
 Example:
 
 sdio2: sdio at 0x3f1a0000 {
 	compatible = "brcm,kona-sdhci";
 	reg = <0x3f1a0000 0x10000>;
+	clocks = <&sdio3_clk>;
 	interrupts = <0x0 74 0x4>;
 };
 
-- 
1.8.0.1
