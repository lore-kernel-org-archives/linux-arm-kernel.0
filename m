From: wxt@rock-chips.com (Caesar Wang)
Date: Fri, 11 Mar 2016 18:55:26 +0800
Subject: [PATCH 1/6] net: arc_emac: make the rockchip emac document more
 compatible
In-Reply-To: <1457693731-6966-1-git-send-email-wxt@rock-chips.com>
References: <1457693731-6966-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1457693731-6966-2-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the all kings of SoCs to compatible.

The rk3036 emac has been landed in mainline, so we should add rk3036 emac
for document.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 Documentation/devicetree/bindings/net/emac_rockchip.txt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/emac_rockchip.txt b/Documentation/devicetree/bindings/net/emac_rockchip.txt
index 8dc1c79..f705bb8 100644
--- a/Documentation/devicetree/bindings/net/emac_rockchip.txt
+++ b/Documentation/devicetree/bindings/net/emac_rockchip.txt
@@ -1,8 +1,10 @@
-* ARC EMAC 10/100 Ethernet platform driver for Rockchip Rk3066/RK3188 SoCs
+* ARC EMAC 10/100 Ethernet platform driver for Rockchip RK3036/Rk3066/RK3188 SoCs
 
 Required properties:
-- compatible: Should be "rockchip,rk3066-emac" or "rockchip,rk3188-emac"
-  according to the target SoC.
+- compatible: should be "rockchip,<name>-emac"
+   "rockchip,rk3036-emac": found on RK3036 SoCs
+   "rockchip,rk3066-emac": found on RK3066 SoCs
+   "rockchip,rockchip,rk3188-emac": found on RK3188 SoCs
 - reg: Address and length of the register set for the device
 - interrupts: Should contain the EMAC interrupts
 - rockchip,grf: phandle to the syscon grf used to control speed and mode
-- 
1.9.1
