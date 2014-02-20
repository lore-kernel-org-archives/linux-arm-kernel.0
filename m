From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 20 Feb 2014 12:11:29 +0100
Subject: [PATCH 1/3] ARM: mvebu: use C preprocessor include for Armada 375/38x
 DTs
In-Reply-To: <1392894691-26837-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1392894691-26837-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1392894691-26837-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some of the Armada 375/38x DTs that were recently submitted were still
using the old-style /include/ instead of the new-style, C-preprocessor
based #include. Since we are going to start including more headers,
switching to the C-preprocessor based includes is important.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-375.dtsi | 2 +-
 arch/arm/boot/dts/armada-380.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
index 9f5cb51..c89fee4 100644
--- a/arch/arm/boot/dts/armada-375.dtsi
+++ b/arch/arm/boot/dts/armada-375.dtsi
@@ -11,7 +11,7 @@
  * warranty of any kind, whether express or implied.
  */
 
-/include/ "skeleton.dtsi"
+#include "skeleton.dtsi"
 
 #define MBUS_ID(target,attributes) (((target) << 24) | ((attributes) << 16))
 
diff --git a/arch/arm/boot/dts/armada-380.dtsi b/arch/arm/boot/dts/armada-380.dtsi
index 5a46ec7..82b3347 100644
--- a/arch/arm/boot/dts/armada-380.dtsi
+++ b/arch/arm/boot/dts/armada-380.dtsi
@@ -12,7 +12,7 @@
  * warranty of any kind, whether express or implied.
  */
 
-/include/ "armada-38x.dtsi"
+#include "armada-38x.dtsi"
 
 / {
 	model = "Marvell Armada 380 family SoC";
-- 
1.8.3.2
