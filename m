From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 20 Jan 2016 19:27:25 +0800
Subject: [PATCH v3 4/4] net: mvneta: update clocks property and document
 additional clock-names
In-Reply-To: <1453289245-2061-1-git-send-email-jszhang@marvell.com>
References: <1453289245-2061-1-git-send-email-jszhang@marvell.com>
Message-ID: <1453289245-2061-5-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 Documentation/devicetree/bindings/net/marvell-armada-370-neta.txt | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/marvell-armada-370-neta.txt b/Documentation/devicetree/bindings/net/marvell-armada-370-neta.txt
index aeea50c..d0cb869 100644
--- a/Documentation/devicetree/bindings/net/marvell-armada-370-neta.txt
+++ b/Documentation/devicetree/bindings/net/marvell-armada-370-neta.txt
@@ -6,12 +6,17 @@ Required properties:
 - interrupts: interrupt for the device
 - phy: See ethernet.txt file in the same directory.
 - phy-mode: See ethernet.txt file in the same directory
-- clocks: a pointer to the reference clock for this device.
+- clocks: List of clocks for this device. At least one clock is
+  mandatory for the core clock. If several clocks are given, then the
+  clock-names property must be used to identify them.
 
 Optional properties:
 - tx-csum-limit: maximum mtu supported by port that allow TX checksum.
   Value is presented in bytes. If not used, by default 1600B is set for
   "marvell,armada-370-neta" and 9800B for others.
+- clock-names: List of names corresponding to clocks property; shall be
+  "core" for core clock and "bus" for the optional bus clock.
+
 
 Example:
 
-- 
2.7.0.rc3
