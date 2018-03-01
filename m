From: enric.balletbo@collabora.com (Enric Balletbo i Serra)
Date: Thu,  1 Mar 2018 10:24:16 +0100
Subject: [PATCH 2/6] dt-bindings: phy-rockchip-typec: move extcon property to
 be optional.
In-Reply-To: <20180301092420.1191-1-enric.balletbo@collabora.com>
References: <20180301092420.1191-1-enric.balletbo@collabora.com>
Message-ID: <20180301092420.1191-3-enric.balletbo@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The extcon property is used to detect the cable-state but some boards,
like Sapphire, currently does not seem to support, others might just not
need, as are supposed to work in host-mode only. So, extcon property is
not really a required property, move to be optional instead.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt b/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
index 6ea867e3176f..a66f23a01129 100644
--- a/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
+++ b/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
@@ -14,6 +14,8 @@ Required properties:
  - resets : a list of phandle + reset specifier pairs
  - reset-names : string reset name, must be:
 		 "uphy", "uphy-pipe", "uphy-tcphy"
+
+Optional properties:
  - extcon : extcon specifier for the Power Delivery
 
 Note, there are 2 type-c phys for RK3399, and they are almost identical, except
-- 
2.16.1
