From: arun.parameswaran@broadcom.com (Arun Parameswaran)
Date: Wed,  1 Aug 2018 10:56:24 -0700
Subject: [PATCH v3 6/8] dt-bindings: net: Add clock handle to Broadcom iProc
 mdio mux
In-Reply-To: <1533146186-8374-1-git-send-email-arun.parameswaran@broadcom.com>
References: <1533146186-8374-1-git-send-email-arun.parameswaran@broadcom.com>
Message-ID: <1533146186-8374-7-git-send-email-arun.parameswaran@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clock phandle, of the core clock driving the mdio block, as an
optional property to the Broadcom iProc mdio mux.

The clock, when specified, will be used to setup the rate adjust registers
in the mdio to derrive the mdio's operating frequency.

Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/net/brcm,mdio-mux-iproc.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/brcm,mdio-mux-iproc.txt b/Documentation/devicetree/bindings/net/brcm,mdio-mux-iproc.txt
index dc8aa68..b58843f 100644
--- a/Documentation/devicetree/bindings/net/brcm,mdio-mux-iproc.txt
+++ b/Documentation/devicetree/bindings/net/brcm,mdio-mux-iproc.txt
@@ -13,6 +13,9 @@ MDIO multiplexer node:
 Every non-ethernet PHY requires a compatible so that it could be probed based
 on this compatible string.
 
+Optional properties:
+- clocks: phandle of the core clock which drives the mdio block.
+
 Additional information regarding generic multiplexer properties can be found
 at- Documentation/devicetree/bindings/net/mdio-mux.txt
 
-- 
1.9.1
