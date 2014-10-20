From: jinkun.hong@rock-chips.com (jinkun.hong)
Date: Mon, 20 Oct 2014 02:03:43 -0700
Subject: [PATCH v4 3/3] ARM: dts: add rk3288 power-domain node
In-Reply-To: <1413795824-3453-1-git-send-email-jinkun.hong@rock-chips.com>
References: <1413795824-3453-1-git-send-email-jinkun.hong@rock-chips.com>
Message-ID: <1413795824-3453-4-git-send-email-jinkun.hong@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "jinkun.hong" <jinkun.hong@rock-chips.com>

Signed-off-by: Jack Dai <jack.dai@rock-chips.com>
Signed-off-by: jinkun.hong <jinkun.hong@rock-chips.com>

---

Changes in v4: None
Changes in v3:
- Decomposition power-controller, changed to multiple controller
   (gpu-power-controller, hevc-power-controller)

Changes in v2:
- make pd_vio clocks all one entry per line and alphabetize.
- power: power-controller move back to pinctrl: pinctrl.

 arch/arm/boot/dts/rk3288.dtsi |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 5950b0a..6a9b313 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -592,4 +592,28 @@
 			};
 		};
 	};
+
+	gpu_power: gpu-power-controller {
+		compatible = "rockchip,rk3288-power-gpu";
+		rockchip,pmu = <&pmu>;
+		#power-domain-cells = <0>;
+	};
+
+	hevc_power: hevc-power-controller {
+		compatible = "rockchip,rk3288-power-hevc";
+		rockchip,pmu = <&pmu>;
+		#power-domain-cells = <0>;
+	};
+
+	video_power: video-power-controller {
+		compatible = "rockchip,rk3288-power-video";
+		rockchip,pmu = <&pmu>;
+		#power-domain-cells = <0>;
+	};
+
+	vio_power: vio-power-controller {
+		compatible = "rockchip,rk3288-power-vio";
+		rockchip,pmu = <&pmu>;
+		#power-domain-cells = <0>;
+	};
 };
-- 
1.7.9.5
