From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon,  9 Apr 2018 11:39:45 +0100
Subject: [PATCH] arm64: dts: juno: drop unnecessary address-cells and
 size-cells properties
Message-ID: <1523270385-30461-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

/smb at 8000000/motherboard/gpio_keys node doesn't have "ranges" or "reg"
property in child nodes. So it's unnecessary to have address-cells
as well as size-cells properties which results in below warning.

Warning (avoid_unnecessary_addr_size):
/smb at 8000000/motherboard/gpio_keys:
	unnecessary #address-cells/#size-cells without "ranges" or child "reg"
	property

This patch drops the unnecessary address+size-cell properties.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/boot/dts/arm/juno-motherboard.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/arm/juno-motherboard.dtsi b/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
index 2ac43221ddb6..69804c5f1197 100644
--- a/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
@@ -56,8 +56,6 @@
 
 			gpio_keys {
 				compatible = "gpio-keys";
-				#address-cells = <1>;
-				#size-cells = <0>;
 
 				power-button {
 					debounce_interval = <50>;
-- 
2.7.4
