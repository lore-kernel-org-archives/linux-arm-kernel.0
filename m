From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 26 Sep 2012 18:02:50 +0200
Subject: [PATCH V5 6/6] arm: l2x0: add aurora related properties to OF binding
In-Reply-To: <1348675370-16359-1-git-send-email-gregory.clement@free-electrons.com>
References: <1348675370-16359-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1348675370-16359-7-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Aurora is a L2 Cache Controller designed to be compatible with the
L2x0 Cache Controller. L2X0 OF bindings are extended to support some
specificity of Aurora (no cache id part number available through
hardware, always write through mode, choice between outer cache and
system cache).

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Yehuda Yitschak <yehuday@marvell.com>
Tested-and-reviewed-by: Lior Amsalem <alior@marvell.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>

Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Barry Song <21cnbao@gmail.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
---
 Documentation/devicetree/bindings/arm/l2cc.txt |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/l2cc.txt b/Documentation/devicetree/bindings/arm/l2cc.txt
index 7ca5216..76b0ee6 100644
--- a/Documentation/devicetree/bindings/arm/l2cc.txt
+++ b/Documentation/devicetree/bindings/arm/l2cc.txt
@@ -10,6 +10,12 @@ Required properties:
 	"arm,pl310-cache"
 	"arm,l220-cache"
 	"arm,l210-cache"
+	"marvell,aurora-system-cache": Marvell Controller designed to be
+     compatible with the ARM one, with system cache mode (meaning
+     maintenance operations on L1 are broadcasted to the L2 and L2
+     performs the same operation).
+	"marvell,"aurora-outer-cache: Marvell Controller designed to be
+	 compatible with the ARM one with outer cache mode.
 - cache-unified : Specifies the cache is a unified cache.
 - cache-level : Should be set to 2 for a level 2 cache.
 - reg : Physical base address and size of cache controller's memory mapped
@@ -29,6 +35,9 @@ Optional properties:
   filter. Addresses in the filter window are directed to the M1 port. Other
   addresses will go to the M0 port.
 - interrupts : 1 combined interrupt.
+- cache-id-part: cache id part number to be used if it is not present
+  on hardware
+- wt-override: If present then L2 is forced to Write through mode
 
 Example:
 
-- 
1.7.9.5
