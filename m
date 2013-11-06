From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 6 Nov 2013 17:48:22 +0530
Subject: [PATCH V2 4/5] mfd: AS3722: add dt node properties for system power
 controller
In-Reply-To: <1383740303-10956-1-git-send-email-ldewangan@nvidia.com>
References: <1383740303-10956-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1383740303-10956-5-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ams AS3722 device supports the power off by turning off its all rails.

Add dt node properties to enable this functionality on this device.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
Changes from V1:
- None

 Documentation/devicetree/bindings/mfd/as3722.txt |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/as3722.txt b/Documentation/devicetree/bindings/mfd/as3722.txt
index e782f39..1a2fa8a 100644
--- a/Documentation/devicetree/bindings/mfd/as3722.txt
+++ b/Documentation/devicetree/bindings/mfd/as3722.txt
@@ -121,6 +121,15 @@ The device node should have the optional properties to support the clock:
 #clock-cells: from common clock binding; shall be set to 1. The clock id for
 	single clock output is 0.
 
+Power-off:
+=========
+
+AS3722 supports the system power off by turning off all its rail. The power off
+is provided through pm power off.
+The device node should have the following properties to enable power-off
+functionality from ams AS3722:
+ams,system-power-controller: To enable the power off functionality through
+	device.
 Example:
 --------
 #include <dt-bindings/mfd/as3722.h>
-- 
1.7.1.1
