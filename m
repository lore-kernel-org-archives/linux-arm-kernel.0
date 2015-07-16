From: m-karicheri2@ti.com (Murali Karicheri)
Date: Thu, 16 Jul 2015 17:51:32 -0400
Subject: [PATCH v1 2/2] ARM: keystone: dts: rename pcie nodes to help override
 status
In-Reply-To: <1437083492-28208-1-git-send-email-m-karicheri2@ti.com>
References: <1437083492-28208-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <1437083492-28208-2-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that PCIe DT binding is disabled in SoC specific DTS,
we need a way to override it in a board specific DTS. So
rename the PCIe nodes accordingly.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 - initial version. Added to the original series
 arch/arm/boot/dts/k2e.dtsi      | 2 +-
 arch/arm/boot/dts/keystone.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/k2e.dtsi b/arch/arm/boot/dts/k2e.dtsi
index ecb9cd6..1b6494f 100644
--- a/arch/arm/boot/dts/k2e.dtsi
+++ b/arch/arm/boot/dts/k2e.dtsi
@@ -86,7 +86,7 @@
 			gpio,syscon-dev = <&devctrl 0x240>;
 		};
 
-		pcie at 21020000 {
+		pcie1: pcie at 21020000 {
 			compatible = "ti,keystone-pcie","snps,dw-pcie";
 			clocks = <&clkpcie1>;
 			clock-names = "pcie";
diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index 0d6be74..e7a6f6d 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -286,7 +286,7 @@
 			ti,syscon-dev = <&devctrl 0x2a0>;
 		};
 
-		pcie at 21800000 {
+		pcie0: pcie at 21800000 {
 			compatible = "ti,keystone-pcie", "snps,dw-pcie";
 			clocks = <&clkpcie>;
 			clock-names = "pcie";
-- 
1.9.1
