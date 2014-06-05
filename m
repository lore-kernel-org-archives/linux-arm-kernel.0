From: andrew.ruder@elecsyscorp.com (Andrew Ruder)
Date: Thu,  5 Jun 2014 14:27:04 -0500
Subject: [PATCH 2/6] pxa-usb: devicetree bindings docs update
In-Reply-To: <cover.1401995177.git.andrew.ruder@elecsyscorp.com>
References: <cover.1401995177.git.andrew.ruder@elecsyscorp.com>
Message-ID: <dde06a6340907cf0fea368d68966ea39cfd4d6e3.1401995177.git.andrew.ruder@elecsyscorp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A few tags documented in pxa-usb.txt don't match the code and one isn't
documented at all.  Updating documentation to match the code.

    marvell,power-sense-low -> marvell,port-sense-low
    marvell,power_on_delay  -> marvell,power-on-delay
    marvell,power-budget (new to documentation)

Signed-off-by: Andrew Ruder <andrew.ruder@elecsyscorp.com>
---
 Documentation/devicetree/bindings/usb/pxa-usb.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/pxa-usb.txt b/Documentation/devicetree/bindings/usb/pxa-usb.txt
index 79729a9..13ab5b0 100644
--- a/Documentation/devicetree/bindings/usb/pxa-usb.txt
+++ b/Documentation/devicetree/bindings/usb/pxa-usb.txt
@@ -13,11 +13,12 @@ Optional properties:
 	1 = PMM_NPS_MODE
 	2 = PMM_GLOBAL_MODE
 	3 = PMM_PERPORT_MODE
- - "marvell,power-sense-low" - power sense pin is low-active.
+ - "marvell,port-sense-low" - power sense pin is low-active.
  - "marvell,power-control-low" - power control pin is low-active.
  - "marvell,no-oc-protection" - disable over-current protection.
  - "marvell,oc-mode-perport" - enable per-port over-current protection.
- - "marvell,power_on_delay" Power On to Power Good time - in ms.
+ - "marvell,power-on-delay" - Power On to Power Good time - in ms.
+ - "marvell,power-budget" - Power budget in mA (0 is no limit)
 
 Example:
 
-- 
1.9.0.rc3.12.gbc97e2d
