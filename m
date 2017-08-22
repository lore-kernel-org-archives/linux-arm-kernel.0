From: andy.yan@rock-chips.com (Andy Yan)
Date: Tue, 22 Aug 2017 21:13:30 +0800
Subject: [PATCH v2 2/3] ARM: dts: rockchip: add cpu power supply for rv1108 evb
In-Reply-To: <1503407515-13943-1-git-send-email-andy.yan@rock-chips.com>
References: <1503407515-13943-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <1503407610-14001-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cpu is powered by regulator vdd_core on RV1108 evalution
board. Add it to the cpu dt node.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

Changes in v2: None

 arch/arm/boot/dts/rv1108-evb.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/rv1108-evb.dts b/arch/arm/boot/dts/rv1108-evb.dts
index 32fb09a..e517aa3 100644
--- a/arch/arm/boot/dts/rv1108-evb.dts
+++ b/arch/arm/boot/dts/rv1108-evb.dts
@@ -104,6 +104,10 @@
 	};
 };
 
+&cpu0 {
+	cpu-supply = <&vdd_core>;
+};
+
 &i2c0 {
 	status = "okay";
 	i2c-scl-rising-time-ns = <275>;
-- 
2.7.4
