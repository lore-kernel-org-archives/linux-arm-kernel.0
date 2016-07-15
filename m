From: briannorris@chromium.org (Brian Norris)
Date: Thu, 14 Jul 2016 18:24:33 -0700
Subject: [PATCH] arm64: dts: rockchip: add spiX aliases for rk3399
Message-ID: <1468545873-134339-1-git-send-email-briannorris@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's nicer to see this:

    # ls -l /sys/bus/spi/devices/
    total 0
    lrwxrwxrwx 1 root root 0 Dec 31  1969 spi0.0 -> ../../../devices/platform/ff1c0000.spi/spi_master/spi0/spi0.0
    lrwxrwxrwx 1 root root 0 Dec 31  1969 spi1.0 -> ../../../devices/platform/ff1d0000.spi/spi_master/spi1/spi1.0
    lrwxrwxrwx 1 root root 0 Dec 31  1969 spi2.0 -> ../../../devices/platform/ff1e0000.spi/spi_master/spi2/spi2.0
    lrwxrwxrwx 1 root root 0 Dec 31  1969 spi5.0 -> ../../../devices/platform/ff200000.spi/spi_master/spi5/spi5.0

than this:

    # ls -l /sys/bus/spi/devices/
    total 0
    lrwxrwxrwx 1 root root 0 Dec 31  1969 spi32763.0 -> ../../../devices/platform/ff200000.spi/spi_master/spi32763/spi32763.0
    lrwxrwxrwx 1 root root 0 Dec 31  1969 spi32764.0 -> ../../../devices/platform/ff1e0000.spi/spi_master/spi32764/spi32764.0
    lrwxrwxrwx 1 root root 0 Dec 31  1969 spi32765.0 -> ../../../devices/platform/ff1d0000.spi/spi_master/spi32765/spi32765.0
    lrwxrwxrwx 1 root root 0 Dec 31  1969 spi32766.0 -> ../../../devices/platform/ff1c0000.spi/spi_master/spi32766/spi32766.0

With the latter, it's much clearer which bus devices are on.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 4c84229789ef..b04abbfd4898 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -70,6 +70,12 @@
 		serial2 = &uart2;
 		serial3 = &uart3;
 		serial4 = &uart4;
+		spi0 = &spi0;
+		spi1 = &spi1;
+		spi2 = &spi2;
+		spi3 = &spi3;
+		spi4 = &spi4;
+		spi5 = &spi5;
 	};
 
 	cpus {
-- 
2.8.0.rc3.226.g39d4020
