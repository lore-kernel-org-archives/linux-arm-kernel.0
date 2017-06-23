From: briannorris@chromium.org (Brian Norris)
Date: Fri, 23 Jun 2017 10:07:37 -0700
Subject: [PATCH 3/3] arm64: dts: rockchip: set rk3399 dynamic CPU power
 coefficients
In-Reply-To: <20170623170737.46265-1-briannorris@chromium.org>
References: <20170623170737.46265-1-briannorris@chromium.org>
Message-ID: <20170623170737.46265-3-briannorris@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide the dynamic power coefficient of the big and little CPU
clusters. These numbers are currently in use on the Samsung Chromebook
Plus ("Kevin").

The power allocator thermal governor doesn't know how to do anything if
it doesn't get power parameters from its cooling devices (in this case,
CPUfreq). So this effectively enables the power-allocator governor.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 69c56f7316c4..4f6667547814 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -109,6 +109,7 @@
 			reg = <0x0 0x0>;
 			enable-method = "psci";
 			#cooling-cells = <2>; /* min followed by max */
+			dynamic-power-coefficient = <100>;
 			clocks = <&cru ARMCLKL>;
 		};
 
@@ -142,6 +143,7 @@
 			reg = <0x0 0x100>;
 			enable-method = "psci";
 			#cooling-cells = <2>; /* min followed by max */
+			dynamic-power-coefficient = <100>;
 			clocks = <&cru ARMCLKB>;
 		};
 
-- 
2.13.1.611.g7e3b11ae1-goog
