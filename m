From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Wed, 30 Mar 2016 10:27:45 -0500
Subject: [PATCH 4/7] Documentation: dt: socfpga: Add Altera Arria10 OCRAM
 binding
In-Reply-To: <1459351668-14622-1-git-send-email-tthayer@opensource.altera.com>
References: <1459351668-14622-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1459351668-14622-5-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

Add the device tree bindings needed to support the Altera On-Chip
RAM ECC on the Arria10 chip.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
 .../bindings/arm/altera/socfpga-eccmgr.txt         |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt
index 37ff9bf..2f409d5 100644
--- a/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt
+++ b/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt
@@ -71,6 +71,11 @@ Required Properties:
 - compatible : Should be "altr,socfpga-a10-l2-ecc"
 - reg : Address and size for ECC error interrupt clear registers.
 
+On-Chip RAM ECC
+Required Properties:
+- compatible : Should be "altr,socfpga-a10-ocram-ecc"
+- reg : Address and size for ECC block registers.
+
 Example:
 
 	eccmgr: eccmgr at ffd06000 {
@@ -86,4 +91,9 @@ Example:
 			compatible = "altr,socfpga-a10-l2-ecc";
 			reg = <0xffd06010 0x4>;
 		};
+
+		ocram-ecc at ff8c3000 {
+			compatible = "altr,socfpga-a10-ocram-ecc";
+			reg = <0xff8c3000 0x90>;
+		};
 	};
-- 
1.7.9.5
