From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Mon, 25 Aug 2014 07:37:11 -0500
Subject: [PATCHv3 3/3] ARM: dts: socfpga: memreserve first 4KB for future
 system use
In-Reply-To: <1408970231-4316-1-git-send-email-dinguyen@opensource.altera.com>
References: <1408970231-4316-1-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <1408970231-4316-4-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

This patch adds a /memreserve/ section to reserve the first 4K for future
use by the system. One possible use-case is trampoline code used to bring
secondary cores online.

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
Acked-by: Pavel Machek <pavel@denx.de>
---
v3: Update commit message based on Mark Rutland's comment
v2: Add a comment in the dts files
---
 arch/arm/boot/dts/socfpga_arria5.dtsi   | 2 ++
 arch/arm/boot/dts/socfpga_cyclone5.dtsi | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga_arria5.dtsi b/arch/arm/boot/dts/socfpga_arria5.dtsi
index 468fc4c..03e8268 100644
--- a/arch/arm/boot/dts/socfpga_arria5.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria5.dtsi
@@ -15,6 +15,8 @@
  */
 
 /dts-v1/;
+/* First 4KB has trampoline code for secondary cores. */
+/memreserve/ 0x00000000 0x0001000;
 #include "socfpga.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/socfpga_cyclone5.dtsi b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
index 33cad8b..28c05e7 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5.dtsi
+++ b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
@@ -16,6 +16,8 @@
  */
 
 /dts-v1/;
+/* First 4KB has trampoline code for secondary cores. */
+/memreserve/ 0x00000000 0x0001000;
 #include "socfpga.dtsi"
 
 / {
-- 
2.0.3
