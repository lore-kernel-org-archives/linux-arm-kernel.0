From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Thu, 14 Apr 2016 14:20:19 +0800
Subject: [PATCH v2 1/2] dt-bindings: modify document of Rockchip power domains
In-Reply-To: <1460614820-18865-1-git-send-email-zhangqing@rock-chips.com>
References: <1460614820-18865-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1460614820-18865-2-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rockchip Socs contain quality of service (qos) blocks managing priority, 
bandwidth, etc of the connection of each domain to the interconnect.
These blocks loose state when their domain gets disabled and therefore
need to be saved when disabling and restored when enabling a power-domain.

These qos blocks also are similar over all currently available Rockchip 
SoCs.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 Documentation/devicetree/bindings/soc/rockchip/power_domain.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt b/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
index 98085c888d65..6c571a40cd31 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
+++ b/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
@@ -21,6 +21,13 @@ Required properties for power domain sub nodes:
 - clocks (optional): phandles to clocks which need to be enabled while power domain
 	switches state.
 
+Qos Example:
+
+	qos_gpu: qos_gpu at ffaf0000 {
+		compatible ="syscon";
+		reg = <0x0 0xffaf0000 0x0 0x20>;
+	};
+
 Example:
 
 	power: power-controller {
@@ -32,6 +39,7 @@ Example:
 		pd_gpu {
 			reg = <RK3288_PD_GPU>;
 			clocks = <&cru ACLK_GPU>;
+			pm_qos = <&qos_gpu>;
 		};
 	};
 
-- 
1.9.1
