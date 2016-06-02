From: m-karicheri2@ti.com (Murali Karicheri)
Date: Thu, 2 Jun 2016 11:17:52 -0400
Subject: [PATCH v1 2/2] ARM: dts: keystone: add interrupt property to PCI
 controller bindings
In-Reply-To: <1464880672-15203-1-git-send-email-m-karicheri2@ti.com>
References: <1464880672-15203-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <1464880672-15203-2-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that Keystone PCIe controller supports error interrupt handling
add interrupt property to PCI controller DT bindings to enable
error interrupt handling.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 - v1 - no change from initial version
 - applies to master v4.7-rcx at kernel.org git repo
 arch/arm/boot/dts/keystone-k2e.dtsi | 2 ++
 arch/arm/boot/dts/keystone.dtsi     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-k2e.dtsi b/arch/arm/boot/dts/keystone-k2e.dtsi
index 5374c9a..9a51b8c 100644
--- a/arch/arm/boot/dts/keystone-k2e.dtsi
+++ b/arch/arm/boot/dts/keystone-k2e.dtsi
@@ -104,6 +104,8 @@
 			num-lanes = <2>;
 			bus-range = <0x00 0xff>;
 
+			/* error interrupt */
+			interrupts = <GIC_SPI 385 IRQ_TYPE_EDGE_RISING>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0 0 0 1 &pcie_intc1 0>, /* INT A */
diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index f627a1c..e23f46d 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -302,6 +302,8 @@
 			num-lanes = <2>;
 			bus-range = <0x00 0xff>;
 
+			/* error interrupt */
+			interrupts = <GIC_SPI 38 IRQ_TYPE_EDGE_RISING>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0 0 0 1 &pcie_intc0 0>, /* INT A */
-- 
1.9.1
