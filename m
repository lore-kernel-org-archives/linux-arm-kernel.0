From: jagannadh.teki@gmail.com (Jagan Teki)
Date: Mon, 11 Sep 2017 13:56:22 +0530
Subject: [PATCH 2/2] ARM: dts: rockchip: rk3288-vyasa: Add hdmi ddc-i2c-bus
In-Reply-To: <1505118382-6023-1-git-send-email-jteki@openedev.com>
References: <1505118382-6023-1-git-send-email-jteki@openedev.com>
Message-ID: <1505118382-6023-2-git-send-email-jteki@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@amarulasolutions.com>

HDMI DDC bus is connected via i2c2 in rk3288-vyasa board,
so add it and enable i2c22 node at same patch.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm/boot/dts/rk3288-vyasa.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-vyasa.dts b/arch/arm/boot/dts/rk3288-vyasa.dts
index f70a52f..fdafe5c 100644
--- a/arch/arm/boot/dts/rk3288-vyasa.dts
+++ b/arch/arm/boot/dts/rk3288-vyasa.dts
@@ -83,6 +83,7 @@
 };
 
 &hdmi {
+	ddc-i2c-bus = <&i2c2>;
 	status = "okay";
 };
 
@@ -279,6 +280,10 @@
 	};
 };
 
+&i2c2 {
+	status = "okay";
+};
+
 &sdmmc {
 	status = "okay";
 
-- 
2.7.4
