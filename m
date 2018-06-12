From: ray.jui@broadcom.com (Ray Jui)
Date: Tue, 12 Jun 2018 13:21:30 -0700
Subject: [PATCH 4/5] ARM64: dts: ns2: Fix PCIe controller interrupt type
In-Reply-To: <1528834891-17807-1-git-send-email-ray.jui@broadcom.com>
References: <1528834891-17807-1-git-send-email-ray.jui@broadcom.com>
Message-ID: <1528834891-17807-5-git-send-email-ray.jui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix PCIe controller interrupt to use IRQ_TYPE_LEVEL_HIGH for
Broadcom NS2 SoC

Fixes: fd5e5dd56a2f ("arm64: dts: Add PCIe0 and PCIe4 DT nodes for NS2")
Fixes: 63a913c157f5 ("arm64: dts: move ns2 into northstar2 directory")

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
index c0e4896..4057197 100644
--- a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
@@ -118,7 +118,7 @@
 
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic 0 GIC_SPI 281 IRQ_TYPE_NONE>;
+		interrupt-map = <0 0 0 0 &gic 0 GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>;
 
 		linux,pci-domain = <0>;
 
@@ -149,7 +149,7 @@
 
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic 0 GIC_SPI 305 IRQ_TYPE_NONE>;
+		interrupt-map = <0 0 0 0 &gic 0 GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
 
 		linux,pci-domain = <4>;
 
-- 
2.1.4
