From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Apr 2014 08:05:51 +0900
Subject: [PATCH v6 2/2] clk: shmobile: r8a7779: Add MSTP clock support
In-Reply-To: <1397775951-30992-1-git-send-email-horms+renesas@verge.net.au>
References: <1397775951-30992-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1397775951-30992-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add MSTP clock support for the r8a7779 SoC

The only change required appears to be to note a new
compatibility string in the bindings.

Cc: devicetree at vger.kernel.org
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v4 - v6
* No Change

v3
* As suggested by Laurent Pinchart
  - Add entry in numerical order
---
 Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
index 5992dce..0708937 100644
--- a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
@@ -10,6 +10,7 @@ index in the group, from 0 to 31.
 Required Properties:
 
   - compatible: Must be one of the following
+    - "renesas,r8a7779-mstp-clocks" for R8A7779 (R-Car H1) MSTP gate clocks
     - "renesas,r8a7790-mstp-clocks" for R8A7790 (R-Car H2) MSTP gate clocks
     - "renesas,r8a7791-mstp-clocks" for R8A7791 (R-Car M2) MSTP gate clocks
     - "renesas,cpg-mstp-clock" for generic MSTP gate clocks
-- 
1.8.4
