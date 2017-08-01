From: m.niestroj@grinn-global.com (Marcin Niestroj)
Date: Tue,  1 Aug 2017 16:14:56 +0200
Subject: [PATCH] ARM: dts: imx6ul-liteboard: Support poweroff
Message-ID: <20170801141456.10844-1-m.niestroj@grinn-global.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support proper system power-off, which disables main regulator. This
results in much lower power consumption and support of power-on issued
by button press.

Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
---
 arch/arm/boot/dts/imx6ul-liteboard.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul-liteboard.dts b/arch/arm/boot/dts/imx6ul-liteboard.dts
index ed1d891d6a89..c4fb5ea28e86 100644
--- a/arch/arm/boot/dts/imx6ul-liteboard.dts
+++ b/arch/arm/boot/dts/imx6ul-liteboard.dts
@@ -145,3 +145,7 @@
 	wakeup-source;
 	status = "okay";
 };
+
+&snvs_poweroff {
+	status = "okay";
+};
-- 
2.13.3
