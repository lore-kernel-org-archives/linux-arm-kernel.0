From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 26 Nov 2018 13:54:08 +0100
Subject: [PATCH 06/16] ARM: dts: r8a779[01]: Disable unconnected LVDS encoders
In-Reply-To: <cover.1543236456.git.horms+renesas@verge.net.au>
References: <cover.1543236456.git.horms+renesas@verge.net.au>
Message-ID: <5e78f9d107c6951b1c266bda1eed099cdc744cb0.1543236456.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The LVDS0 encoder on Koelsh and Porter, and the LVDS1 encoder on Lager,
are enabled in DT but have no device connected to their output. This
result in spurious messages being printed to the kernel log such as

rcar-du feb00000.display: no connector for encoder /soc/lvds at feb90000, skipping

Fix it by disabling the encoders.

Fixes: 15a1ff30d8f9 ("ARM: dts: r8a7790: Convert to new LVDS DT bindings")
Fixes: e5c3f4707f39 ("ARM: dts: r8a7791: Convert to new LVDS DT bindings")
Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts   | 2 --
 arch/arm/boot/dts/r8a7791-koelsch.dts | 2 --
 arch/arm/boot/dts/r8a7791-porter.dts  | 2 --
 3 files changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 50312e752e2f..7b9508e83d46 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -489,8 +489,6 @@
 };
 
 &lvds1 {
-	status = "okay";
-
 	ports {
 		port at 1 {
 			lvds_connector: endpoint {
diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index ce22db01fbba..e6580aa0cea3 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -479,8 +479,6 @@
 };
 
 &lvds0 {
-	status = "okay";
-
 	ports {
 		port at 1 {
 			lvds_connector: endpoint {
diff --git a/arch/arm/boot/dts/r8a7791-porter.dts b/arch/arm/boot/dts/r8a7791-porter.dts
index f02036e5de01..fefdf8238bbe 100644
--- a/arch/arm/boot/dts/r8a7791-porter.dts
+++ b/arch/arm/boot/dts/r8a7791-porter.dts
@@ -482,8 +482,6 @@
 };
 
 &lvds0 {
-	status = "okay";
-
 	ports {
 		port at 1 {
 			lvds_connector: endpoint {
-- 
2.11.0
