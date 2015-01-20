From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Tue, 20 Jan 2015 13:07:51 +0800
Subject: [PATCH 2/2] arm64/dts: ajust cpu nodes base upon new attribute
 reg-var-mask
In-Reply-To: <1421730471-8256-1-git-send-email-thunder.leizhen@huawei.com>
References: <1421730471-8256-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1421730471-8256-2-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To show all the styles currently supported, have not merged all cpu
nodes into one. Treat foundation-v8.dts as a example file.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm64/boot/dts/arm/foundation-v8.dts |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/arm/foundation-v8.dts b/arch/arm64/boot/dts/arm/foundation-v8.dts
index 27f3296..4118755 100644
--- a/arch/arm64/boot/dts/arm/foundation-v8.dts
+++ b/arch/arm64/boot/dts/arm/foundation-v8.dts
@@ -28,17 +28,15 @@
 		#address-cells = <2>;
 		#size-cells = <0>;

-		cpu at 0 {
+		/*
+		 * These three cpu nodes can be merged into one. Here just in
+		 * order to show all the styles currently supported.
+		 */
+		cpu at 0-1 {
 			device_type = "cpu";
 			compatible = "arm,armv8";
 			reg = <0x0 0x0>;
-			enable-method = "spin-table";
-			cpu-release-addr = <0x0 0x8000fff8>;
-		};
-		cpu at 1 {
-			device_type = "cpu";
-			compatible = "arm,armv8";
-			reg = <0x0 0x1>;
+			reg-var-mask = <0x0 0x1>;
 			enable-method = "spin-table";
 			cpu-release-addr = <0x0 0x8000fff8>;
 		};
@@ -46,6 +44,7 @@
 			device_type = "cpu";
 			compatible = "arm,armv8";
 			reg = <0x0 0x2>;
+			reg-var-mask = <0x0 0x0>;
 			enable-method = "spin-table";
 			cpu-release-addr = <0x0 0x8000fff8>;
 		};
--
1.7.1
