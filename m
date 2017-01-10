From: zhengxing@rock-chips.com (Xing Zheng)
Date: Tue, 10 Jan 2017 14:15:30 +0800
Subject: [PATCH v4 2/2] dt-bindings: clk: add rockchip, grf property for RK3399
In-Reply-To: <1484028930-20305-1-git-send-email-zhengxing@rock-chips.com>
References: <1484028930-20305-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <1484028930-20305-3-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for rockchip,grf property which is used for GRF muxes
on RK3399.

Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
---

Changes in v4:
- update the decription for rockchip,grf property

Changes in v3: None
Changes in v2: None

 Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.txt b/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.txt
index 3888dd3..3bc56fa 100644
--- a/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.txt
+++ b/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.txt
@@ -13,6 +13,12 @@ Required Properties:
 - #clock-cells: should be 1.
 - #reset-cells: should be 1.
 
+Optional Properties:
+
+- rockchip,grf: phandle to the syscon managing the "general register files".
+  It is used for GRF muxes, if missing any muxes present in the GRF will not
+  be available.
+
 Each clock is assigned an identifier and client nodes can use this identifier
 to specify the clock which they consume. All available clocks are defined as
 preprocessor macros in the dt-bindings/clock/rk3399-cru.h headers and can be
-- 
2.7.4
