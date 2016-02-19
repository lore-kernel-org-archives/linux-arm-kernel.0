From: jay.xu@rock-chips.com (jianqun.xu)
Date: Fri, 19 Feb 2016 09:56:14 +0800
Subject: [PATCH v4 2/6] soc: rockchip: add bindings for Rockchip grf
In-Reply-To: <1455846978-4272-1-git-send-email-jay.xu@rock-chips.com>
References: <1455846978-4272-1-git-send-email-jay.xu@rock-chips.com>
Message-ID: <1455846978-4272-3-git-send-email-jay.xu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jianqun Xu <jay.xu@rock-chips.com>

Add devicetree bindings for Rockchip grf which found on
Rockchip SoCs.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
---
changes in v4:
- new add

 .../devicetree/bindings/soc/rockchip/grf.txt       | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/rockchip/grf.txt

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.txt b/Documentation/devicetree/bindings/soc/rockchip/grf.txt
new file mode 100644
index 0000000..7fb0410
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.txt
@@ -0,0 +1,35 @@
+* Rockchip General Register Files (GRF)
+
+The general register file will be used to do static set by software, which
+is composed of many registers for system control.
+
+From RK3368 SoCs, the GRF is divided into two sections,
+- GRF, used for general non-secure system,
+- PMUGRF, used for always on sysyem
+
+Required Properties:
+
+- compatible: GRF should be one of the followings
+   - "rockchip,rk3066-grf", "syscon": for rk3066
+   - "rockchip,rk3188-grf", "syscon": for rk3188
+   - "rockchip,rk3228-grf", "syscon": for rk3228
+   - "rockchip,rk3288-grf", "syscon": for rk3288
+   - "rockchip,rk3368-grf", "syscon": for rk3368
+   - "rockchip,rk3399-grf", "syscon": for rk3399
+- compatible: PMUGRF should be one of the followings
+   - "rockchip,rk3368-pmugrf", "syscon": for rk3368
+   - "rockchip,rk3399-pmugrf", "syscon": for rk3399
+- reg: physical base address of the controller and length of memory mapped
+  region.
+
+Example: GRF and PMUGRF of RK3399 SoCs
+
+	pmugrf: syscon at ff320000 {
+		compatible = "rockchip,rk3399-pmugrf", "syscon";
+		reg = <0x0 0xff320000 0x0 0x1000>;
+	};
+
+	grf: syscon at ff770000 {
+		compatible = "rockchip,rk3399-grf", "syscon";
+		reg = <0x0 0xff770000 0x0 0x10000>;
+	};
-- 
1.9.1
