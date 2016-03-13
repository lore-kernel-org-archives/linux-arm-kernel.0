From: wxt@rock-chips.com (Caesar Wang)
Date: Sun, 13 Mar 2016 17:07:34 +0800
Subject: [PATCH v2 1/9] net: arc_emac: make the rockchip emac document more
 compatible
In-Reply-To: <1457860062-5514-1-git-send-email-wxt@rock-chips.com>
References: <1457860062-5514-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1457860062-5514-2-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the rk3036 SoCs to match driver for document since he emac driver
has supported the rk3036 SoCs.

This patch adds the rk3036/rk3066/rk3188 SoCS to compatible for rockchip
emac ducument. Also, that will suit for other SoCs in the future.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>

---

Changes in v2:
- change the commit and remove the repeat the name 'rockchip'.

 Documentation/devicetree/bindings/net/emac_rockchip.txt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/emac_rockchip.txt b/Documentation/devicetree/bindings/net/emac_rockchip.txt
index 8dc1c79..05bd7da 100644
--- a/Documentation/devicetree/bindings/net/emac_rockchip.txt
+++ b/Documentation/devicetree/bindings/net/emac_rockchip.txt
@@ -1,8 +1,10 @@
-* ARC EMAC 10/100 Ethernet platform driver for Rockchip Rk3066/RK3188 SoCs
+* ARC EMAC 10/100 Ethernet platform driver for Rockchip RK3036/RK3066/RK3188 SoCs
 
 Required properties:
-- compatible: Should be "rockchip,rk3066-emac" or "rockchip,rk3188-emac"
-  according to the target SoC.
+- compatible: should be "rockchip,<name>-emac"
+   "rockchip,rk3036-emac": found on RK3036 SoCs
+   "rockchip,rk3066-emac": found on RK3066 SoCs
+   "rockchip,rk3188-emac": found on RK3188 SoCs
 - reg: Address and length of the register set for the device
 - interrupts: Should contain the EMAC interrupts
 - rockchip,grf: phandle to the syscon grf used to control speed and mode
-- 
1.9.1
