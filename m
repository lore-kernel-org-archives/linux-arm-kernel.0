From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 15 Sep 2017 11:18:09 +0200
Subject: [PATCH v2 5/8] ARM: dts: rockchip: enable the gpu on rk3036-kylin
 boards
In-Reply-To: <20170915091812.13368-1-heiko@sntech.de>
References: <20170915091812.13368-1-heiko@sntech.de>
Message-ID: <20170915091812.13368-6-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the gpu node and add the gpu supply for it.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3036-kylin.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/rk3036-kylin.dts b/arch/arm/boot/dts/rk3036-kylin.dts
index fdb1570bc7d3..e2a0f576946f 100644
--- a/arch/arm/boot/dts/rk3036-kylin.dts
+++ b/arch/arm/boot/dts/rk3036-kylin.dts
@@ -135,6 +135,11 @@
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&vdd_gpu>;
+	status = "okay";
+};
+
 &hdmi {
 	status = "okay";
 };
-- 
2.14.1
