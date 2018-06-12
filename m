From: ray.jui@broadcom.com (Ray Jui)
Date: Tue, 12 Jun 2018 13:21:29 -0700
Subject: [PATCH 3/5] ARM64: dts: ns2: Fix I2C controller interrupt type
In-Reply-To: <1528834891-17807-1-git-send-email-ray.jui@broadcom.com>
References: <1528834891-17807-1-git-send-email-ray.jui@broadcom.com>
Message-ID: <1528834891-17807-4-git-send-email-ray.jui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix I2C controller interrupt to use IRQ_TYPE_LEVEL_HIGH for
Broadcom NS2 SoC

Fixes: 7ac674e8df7a ("arm64: dts: Add I2C nodes for NS2")
Fixes: 63a913c157f5 ("arm64: dts: move ns2 into northstar2 directory")

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
index 4a2a6af..c0e4896 100644
--- a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
@@ -566,7 +566,7 @@
 			reg = <0x66080000 0x100>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <GIC_SPI 394 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 394 IRQ_TYPE_LEVEL_HIGH>;
 			clock-frequency = <100000>;
 			status = "disabled";
 		};
@@ -594,7 +594,7 @@
 			reg = <0x660b0000 0x100>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <GIC_SPI 395 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>;
 			clock-frequency = <100000>;
 			status = "disabled";
 		};
-- 
2.1.4
