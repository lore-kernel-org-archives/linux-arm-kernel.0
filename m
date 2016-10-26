From: jon.mason@broadcom.com (Jon Mason)
Date: Wed, 26 Oct 2016 15:35:58 -0400
Subject: [PATCH 2/5] Documentation: devicetree: net: add NS2 bindings to amac
In-Reply-To: <1477510561-17035-1-git-send-email-jon.mason@broadcom.com>
References: <1477510561-17035-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <1477510561-17035-3-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jon Mason <jon.mason@broadcom.com>
---
 Documentation/devicetree/bindings/net/brcm,amac.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/brcm,amac.txt b/Documentation/devicetree/bindings/net/brcm,amac.txt
index ba5ecc1..f92caee 100644
--- a/Documentation/devicetree/bindings/net/brcm,amac.txt
+++ b/Documentation/devicetree/bindings/net/brcm,amac.txt
@@ -2,15 +2,18 @@ Broadcom AMAC Ethernet Controller Device Tree Bindings
 -------------------------------------------------------------
 
 Required properties:
- - compatible:	"brcm,amac" or "brcm,nsp-amac"
+ - compatible:	"brcm,amac", "brcm,nsp-amac", or "brcm,ns2-amac"
  - reg:		Address and length of the GMAC registers,
 		Address and length of the GMAC IDM registers
+		Address and length of the NIC Port Manager registers (optional)
  - reg-names:	Names of the registers.  Must have both "amac_base" and
-		"idm_base"
+		"idm_base". "nicpm_base" is optional (required for NS2)
  - interrupts:	Interrupt number
 
 Optional properties:
 - mac-address:	See ethernet.txt file in the same directory
+- brcm,enet-phy-lane-swap:
+		boolean; Swap the PHY lanes (needed on some SKUs of NS2)
 
 Examples:
 
-- 
2.7.4
