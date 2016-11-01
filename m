From: jon.mason@broadcom.com (Jon Mason)
Date: Tue,  1 Nov 2016 16:04:39 -0400
Subject: [PATCH v4 4/7] Documentation: devicetree: net: add NS2 bindings to
 amac
In-Reply-To: <1478030682-27012-1-git-send-email-jon.mason@broadcom.com>
References: <1478030682-27012-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <1478030682-27012-5-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clean-up the documentation to the bgmac-amac driver, per suggestion by
Rob Herring, and add details for NS2 support.

Signed-off-by: Jon Mason <jon.mason@broadcom.com>
---
 Documentation/devicetree/bindings/net/brcm,amac.txt | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/brcm,amac.txt b/Documentation/devicetree/bindings/net/brcm,amac.txt
index ba5ecc1..2fefa1a 100644
--- a/Documentation/devicetree/bindings/net/brcm,amac.txt
+++ b/Documentation/devicetree/bindings/net/brcm,amac.txt
@@ -2,11 +2,17 @@ Broadcom AMAC Ethernet Controller Device Tree Bindings
 -------------------------------------------------------------
 
 Required properties:
- - compatible:	"brcm,amac" or "brcm,nsp-amac"
- - reg:		Address and length of the GMAC registers,
-		Address and length of the GMAC IDM registers
- - reg-names:	Names of the registers.  Must have both "amac_base" and
-		"idm_base"
+ - compatible:	"brcm,amac"
+		"brcm,nsp-amac"
+		"brcm,ns2-amac"
+ - reg:		Address and length of the register set for the device. It
+		contains the information of registers in the same order as
+		described by reg-names
+ - reg-names:	Names of the registers.
+		"amac_base":	Address and length of the GMAC registers
+		"idm_base":	Address and length of the GMAC IDM registers
+		"nicpm_base":	Address and length of the NIC Port Manager
+				registers (required for Northstar2)
  - interrupts:	Interrupt number
 
 Optional properties:
-- 
2.7.4
