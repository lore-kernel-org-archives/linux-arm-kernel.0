From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri,  1 Apr 2016 08:52:58 +0100
Subject: [PATCH v3 3/3] ARM: dts: apq8064: add ahci ports-implemented mask
In-Reply-To: <1459497178-31090-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1459497178-31090-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1459497178-31090-4-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds new ports-implemented mask, which is required to get
achi working on the mainline. Without this patch value read from
PORTS_IMPL register which is zero would not enable any ports for
software to use.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Andy Gross <andy.gross@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 252b310..36e058c 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -696,7 +696,7 @@
 		};
 
 		sata0: sata at 29000000 {
-			compatible		= "generic-ahci";
+			compatible		= "qcom,apq8064-ahci", "generic-ahci";
 			status			= "disabled";
 			reg			= <0x29000000 0x180>;
 			interrupts		= <GIC_SPI 209 IRQ_TYPE_NONE>;
@@ -718,6 +718,7 @@
 
 			phys			= <&sata_phy0>;
 			phy-names		= "sata-phy";
+			ports-implemented	= <0x1>;
 		};
 
 		/* Temporary fixed regulator */
-- 
2.5.0
