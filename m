From: anup.patel@broadcom.com (Anup Patel)
Date: Fri, 2 Oct 2015 23:24:18 +0530
Subject: [PATCH 1/6] arm64: dts: Add L2-cache DT node for NS2
In-Reply-To: <1443808463-21120-1-git-send-email-anup.patel@broadcom.com>
References: <1443808463-21120-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1443808463-21120-2-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recent kernels requires cache hierrachy to be defined via DT hence
this patch updates NS2 DT accordingly.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Reviewed-by: Sandeep Tripathy <tripathy@broadcom.com>
Reviewed-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/ns2.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/ns2.dtsi b/arch/arm64/boot/dts/broadcom/ns2.dtsi
index 3c92d92..f759175 100644
--- a/arch/arm64/boot/dts/broadcom/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/ns2.dtsi
@@ -50,6 +50,7 @@
 			reg = <0 0>;
 			enable-method = "spin-table";
 			cpu-release-addr = <0 0x84b00000>;
+			next-level-cache = <&CLUSTER0_L2>;
 		};
 
 		cpu at 1 {
@@ -58,6 +59,7 @@
 			reg = <0 1>;
 			enable-method = "spin-table";
 			cpu-release-addr = <0 0x84b00000>;
+			next-level-cache = <&CLUSTER0_L2>;
 		};
 
 		cpu at 2 {
@@ -66,6 +68,7 @@
 			reg = <0 2>;
 			enable-method = "spin-table";
 			cpu-release-addr = <0 0x84b00000>;
+			next-level-cache = <&CLUSTER0_L2>;
 		};
 
 		cpu at 3 {
@@ -74,6 +77,11 @@
 			reg = <0 3>;
 			enable-method = "spin-table";
 			cpu-release-addr = <0 0x84b00000>;
+			next-level-cache = <&CLUSTER0_L2>;
+		};
+
+		CLUSTER0_L2: l2-cache at 000 {
+			compatible = "cache";
 		};
 	};
 
-- 
1.9.1
