From: urjaman@gmail.com (Urja Rannikko)
Date: Tue, 28 Aug 2018 18:55:08 +0000
Subject: [PATCH 2/7] dt-bindings: clock: rk3288-cru: Add property to dedicate
 NPLL for VOPx
In-Reply-To: <20180828185513.13216-1-urjaman@gmail.com>
References: <20180828185513.13216-1-urjaman@gmail.com>
Message-ID: <20180828185513.13216-3-urjaman@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Urja Rannikko <urjaman@gmail.com>
---
 .../devicetree/bindings/clock/rockchip,rk3288-cru.txt          | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3288-cru.txt b/Documentation/devicetree/bindings/clock/rockchip,rk3288-cru.txt
index 8cb47c39ba53..20724584e0a4 100644
--- a/Documentation/devicetree/bindings/clock/rockchip,rk3288-cru.txt
+++ b/Documentation/devicetree/bindings/clock/rockchip,rk3288-cru.txt
@@ -16,6 +16,9 @@ Optional Properties:
 
 - rockchip,grf: phandle to the syscon managing the "general register files"
   If missing pll rates are not changeable, due to the missing pll lock status.
+- rockchip,npll-for-vop: u32 0 or 1, dedicates NPLL to a VOP output unit for
+  more frequency flexibility for the selected VOP output at a cost of
+  flexibility for other devices. Disabled if not present or -1.
 
 Each clock is assigned an identifier and client nodes can use this identifier
 to specify the clock which they consume. All available clocks are defined as
-- 
2.18.0
