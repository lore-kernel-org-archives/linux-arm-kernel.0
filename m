From: arun.parameswaran@broadcom.com (Arun Parameswaran)
Date: Thu, 26 Jul 2018 11:36:18 -0700
Subject: [PATCH 1/7] dt-bindings: net: Fix Broadcom iProc mdio mux driver base
 address
In-Reply-To: <1532630184-29450-1-git-send-email-arun.parameswaran@broadcom.com>
References: <1532630184-29450-1-git-send-email-arun.parameswaran@broadcom.com>
Message-ID: <1532630184-29450-2-git-send-email-arun.parameswaran@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Modify the base address passed to the Broadcom iProc MDIO mux driver
to point to the start of the block's register address space.

Fixes: ce8d5dbfd64f ("Add DT binding doc for Broadcom MDIO bus multiplexer")
Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
---
 Documentation/devicetree/bindings/net/brcm,mdio-mux-iproc.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/brcm,mdio-mux-iproc.txt b/Documentation/devicetree/bindings/net/brcm,mdio-mux-iproc.txt
index dfe287a..dc8aa68 100644
--- a/Documentation/devicetree/bindings/net/brcm,mdio-mux-iproc.txt
+++ b/Documentation/devicetree/bindings/net/brcm,mdio-mux-iproc.txt
@@ -18,9 +18,9 @@ at- Documentation/devicetree/bindings/net/mdio-mux.txt
 
 
 for example:
-		mdio_mux_iproc: mdio-mux at 6602023c {
+		mdio_mux_iproc: mdio-mux at 66020000 {
 			compatible = "brcm,mdio-mux-iproc";
-			reg = <0x6602023c 0x14>;
+			reg = <0x66020000 0x250>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-- 
1.9.1
