From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 20 Jan 2016 16:06:23 +0800
Subject: [PATCH 4/4] net: mvneta: update clocks property and document
 additional clock-names
In-Reply-To: <1453277183-5412-1-git-send-email-jszhang@marvell.com>
References: <1453277183-5412-1-git-send-email-jszhang@marvell.com>
Message-ID: <1453277183-5412-5-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that mvneta driver allows to have more than one clock defined,
update the clocks property and document the clock-names property.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 Documentation/devicetree/bindings/net/marvell-armada-370-neta.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/marvell-armada-370-neta.txt b/Documentation/devicetree/bindings/net/marvell-armada-370-neta.txt
index aeea50c..f85b93b 100644
--- a/Documentation/devicetree/bindings/net/marvell-armada-370-neta.txt
+++ b/Documentation/devicetree/bindings/net/marvell-armada-370-neta.txt
@@ -6,12 +6,16 @@ Required properties:
 - interrupts: interrupt for the device
 - phy: See ethernet.txt file in the same directory.
 - phy-mode: See ethernet.txt file in the same directory
-- clocks: a pointer to the reference clock for this device.
+- clocks: Array of clocks required for this device; requires at least one
+  for CORE clock.
 
 Optional properties:
 - tx-csum-limit: maximum mtu supported by port that allow TX checksum.
   Value is presented in bytes. If not used, by default 1600B is set for
   "marvell,armada-370-neta" and 9800B for others.
+- clock-names: Array of names corresponding to clocks property; shall be
+  "core" for CORE clock and "axi" for optional AXI clock.
+
 
 Example:
 
-- 
2.7.0.rc3
