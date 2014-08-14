From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Thu, 14 Aug 2014 16:13:34 -0500
Subject: [PATCHv2 3/3] ARM: dts: socfpga: memreserve first 4KB for SMP code
In-Reply-To: <1408050814-28595-1-git-send-email-dinguyen@opensource.altera.com>
References: <1408050814-28595-1-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <1408050814-28595-4-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

The SOCFPGA's SMP code uses 0x0 for as the location for the trampoline to
bring secondary cores online. This patch adds a /memreserve/ section to
reserve the first 4K for the SMP trampoline code.

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
Acked-by: Pavel Machek <pavel@denx.de>
---
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
