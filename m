From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 6 Nov 2013 17:48:20 +0530
Subject: [PATCH V2 2/5] mfd: as3722: add DT details for clock support of ams
 AS3722
In-Reply-To: <1383740303-10956-1-git-send-email-ldewangan@nvidia.com>
References: <1383740303-10956-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1383740303-10956-3-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT details for using the clocks from ams AS3722.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
Changes from V1:
- This is new patch of series which was part of code change, splitting it
 on different change.

 Documentation/devicetree/bindings/mfd/as3722.txt |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/as3722.txt b/Documentation/devicetree/bindings/mfd/as3722.txt
index fc2191e..e782f39 100644
--- a/Documentation/devicetree/bindings/mfd/as3722.txt
+++ b/Documentation/devicetree/bindings/mfd/as3722.txt
@@ -112,6 +112,15 @@ Following are properties of regulator subnode.
 		ams,enable-tracking: Enable tracking with SD1, only supported
 			by LDO3.
 
+Clock:
+======
+AS3722 supports one 32KHz clock to output from device. The clock control is
+provided through the clock driver.
+This binding uses the common clock binding ./clock-bindings.txt.
+The device node should have the optional properties to support the clock:
+#clock-cells: from common clock binding; shall be set to 1. The clock id for
+	single clock output is 0.
+
 Example:
 --------
 #include <dt-bindings/mfd/as3722.h>
-- 
1.7.1.1
