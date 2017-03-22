From: robh@kernel.org (Rob Herring)
Date: Tue, 21 Mar 2017 21:03:01 -0500
Subject: [PATCH 03/15] ARM: dts: ti: fix PCI bus dtc warnings
In-Reply-To: <20170322020313.24338-1-robh@kernel.org>
References: <20170322020313.24338-1-robh@kernel.org>
Message-ID: <20170322020313.24338-3-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dtc recently added PCI bus checks. Fix these warnings.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: "Beno?t Cousson" <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap at vger.kernel.org
---
Sub-arch maintainers, please apply to your trees unless arm-soc wants 
to take the whole lot.

 arch/arm/boot/dts/dra7.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 2c9e56f4aac5..bbfb9d5a70a9 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -283,6 +283,7 @@
 				device_type = "pci";
 				ranges = <0x81000000 0 0          0x03000 0 0x00010000
 					  0x82000000 0 0x20013000 0x13000 0 0xffed000>;
+				bus-range = <0x00 0xff>;
 				#interrupt-cells = <1>;
 				num-lanes = <1>;
 				linux,pci-domain = <0>;
@@ -319,6 +320,7 @@
 				device_type = "pci";
 				ranges = <0x81000000 0 0          0x03000 0 0x00010000
 					  0x82000000 0 0x30013000 0x13000 0 0xffed000>;
+				bus-range = <0x00 0xff>;
 				#interrupt-cells = <1>;
 				num-lanes = <1>;
 				linux,pci-domain = <1>;
-- 
2.10.1
