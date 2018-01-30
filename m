From: embed3d@gmail.com (Philipp Rossak)
Date: Tue, 30 Jan 2018 18:46:55 +0100
Subject: [PATCH v5 5/6] arm: dts: sun8i: a83t: bananapi-m3: Enable IR
 controller
In-Reply-To: <20180130174656.10657-1-embed3d@gmail.com>
References: <20180130174656.10657-1-embed3d@gmail.com>
Message-ID: <20180130174656.10657-6-embed3d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Bananapi M3 has an onboard IR receiver.
This enables the onboard IR receiver subnode.
Unlike the other IR receivers this one needs a base clock frequency
of 3000000 Hz (3 MHz), to be able to work.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
index 6550bf0e594b..26c015fd4f4d 100644
--- a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
@@ -145,6 +145,11 @@
 	status = "okay";
 };
 
+&r_cir {
+	clock-frequency = <3000000>;
+	status = "okay";
+};
+
 &r_rsb {
 	status = "okay";
 
-- 
2.11.0
