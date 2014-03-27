From: dinguyen@altera.com (dinguyen at altera.com)
Date: Wed, 26 Mar 2014 22:45:12 -0500
Subject: [PATCH 3/3] dts: stmmac: Document the clocks property in the stmmac
 base document
In-Reply-To: <1395891912-26855-1-git-send-email-dinguyen@altera.com>
References: <1395891912-26855-1-git-send-email-dinguyen@altera.com>
Message-ID: <1395891912-26855-4-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

Add the clocks and clock-names property to the base stmmac dts bindings
document.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
---
 Documentation/devicetree/bindings/net/stmmac.txt |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/stmmac.txt b/Documentation/devicetree/bindings/net/stmmac.txt
index 94604e2..9897fa3 100644
--- a/Documentation/devicetree/bindings/net/stmmac.txt
+++ b/Documentation/devicetree/bindings/net/stmmac.txt
@@ -32,6 +32,10 @@ Optional properties:
 	reset phandle is given
 - max-frame-size:	Maximum Transfer Unit (IEEE defined MTU), rather
 			than the maximum frame size.
+- clocks: If present, the first clock should be the GMAC main clock,
+  further clocks may be specified in derived bindings.
+- clocks-names: One name for each entry in the clocks property, the
+  first one should be "stmmaceth".
 
 Examples:
 
@@ -44,4 +48,6 @@ Examples:
 		mac-address = [000000000000]; /* Filled in by U-Boot */
 		max-frame-size = <3800>;
 		phy-mode = "gmii";
+		clocks = <&clock>;
+		clock-names = "stmmaceth">;
 	};
-- 
1.7.9.5
