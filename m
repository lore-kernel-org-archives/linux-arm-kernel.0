From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 23 May 2016 16:58:57 +0200
Subject: [PATCH 1/3] dt-bindings: add used but undocumented rockchip grf
 compatible values
In-Reply-To: <1464015539-19521-1-git-send-email-heiko@sntech.de>
References: <1464015539-19521-1-git-send-email-heiko@sntech.de>
Message-ID: <1464015539-19521-2-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are some more General Register Files used in devicetree files
already, but as of now undocumented in the binding document, fix that.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 Documentation/devicetree/bindings/soc/rockchip/grf.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.txt b/Documentation/devicetree/bindings/soc/rockchip/grf.txt
index 013e71a..c6e62cb 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.txt
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.txt
@@ -5,11 +5,13 @@ is composed of many registers for system control.
 
 From RK3368 SoCs, the GRF is divided into two sections,
 - GRF, used for general non-secure system,
+- SGRF, used for general secure system,
 - PMUGRF, used for always on system
 
 Required Properties:
 
 - compatible: GRF should be one of the followings
+   - "rockchip,rk3036-grf", "syscon": for rk3036
    - "rockchip,rk3066-grf", "syscon": for rk3066
    - "rockchip,rk3188-grf", "syscon": for rk3188
    - "rockchip,rk3228-grf", "syscon": for rk3228
@@ -19,6 +21,8 @@ Required Properties:
 - compatible: PMUGRF should be one of the followings
    - "rockchip,rk3368-pmugrf", "syscon": for rk3368
    - "rockchip,rk3399-pmugrf", "syscon": for rk3399
+- compatible: SGRF should be one of the following
+   - "rockchip,rk3288-sgrf", "syscon": for rk3288
 - reg: physical base address of the controller and length of memory mapped
   region.
 
-- 
2.6.4
