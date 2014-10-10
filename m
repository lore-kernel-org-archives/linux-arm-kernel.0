From: kever.yang@rock-chips.com (Kever Yang)
Date: Fri, 10 Oct 2014 15:25:15 -0700
Subject: [PATCH 2/2] ARM: dts: rockchip: add reset for CPU nodes
In-Reply-To: <1412979915-19746-1-git-send-email-kever.yang@rock-chips.com>
References: <1412979915-19746-1-git-send-email-kever.yang@rock-chips.com>
Message-ID: <1412979915-19746-3-git-send-email-kever.yang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add reset for CPU nodes to use the reset controller.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

 arch/arm/boot/dts/rk3288.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 5e9c56d..291014d 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -53,21 +53,25 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a12";
 			reg = <0x500>;
+			resets = <&cru SRST_CORE0>;
 		};
 		cpu at 501 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a12";
 			reg = <0x501>;
+			resets = <&cru SRST_CORE1>;
 		};
 		cpu at 502 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a12";
 			reg = <0x502>;
+			resets = <&cru SRST_CORE2>;
 		};
 		cpu at 503 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a12";
 			reg = <0x503>;
+			resets = <&cru SRST_CORE3>;
 		};
 	};
 
-- 
1.9.1
