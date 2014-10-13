From: kever.yang@rock-chips.com (Kever Yang)
Date: Mon, 13 Oct 2014 13:12:02 -0700
Subject: [PATCH v4 6/6] ARM: dts: rockchip: add reset for CPU nodes
In-Reply-To: <1413231122-1770-1-git-send-email-kever.yang@rock-chips.com>
References: <1413231122-1770-1-git-send-email-kever.yang@rock-chips.com>
Message-ID: <1413231122-1770-7-git-send-email-kever.yang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add reset for CPU nodes to use the reset controller.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 arch/arm/boot/dts/rk3288.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 726c5c7..cb614fc 100644
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
