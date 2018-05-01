From: linux.amoon@gmail.com (Anand Moon)
Date: Wed,  2 May 2018 00:29:02 +0530
Subject: [PATCH 2/2] ARM64: dts: meson: update maximum frequency for sdcard to
 200MHz
In-Reply-To: <20180501185902.3556-1-linux.amoon@gmail.com>
References: <20180501185902.3556-1-linux.amoon@gmail.com>
Message-ID: <20180501185902.3556-2-linux.amoon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

update the maximum frequency of the sdcard to 200Mhz
to support high speed read/write with uhs mode.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
odroid at odroid64:~$ sudo cat /sys/kernel/debug/mmc1/ios
[sudo] password for odroid:
clock:          200000000 Hz
actual clock:   200000000 Hz
vdd:            21 (3.3 ~ 3.4 V)
bus mode:       2 (push-pull)
chip select:    0 (don't care)
power mode:     2 (on)
bus width:      2 (4 bits)
timing spec:    6 (sd uhs SDR104)
signal voltage: 1 (1.80 V)
driver type:    0 (driver type B)
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index c90f8b46c60c..ab868eaddb46 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -256,7 +256,7 @@
 
 	bus-width = <4>;
 	cap-sd-highspeed;
-	max-frequency = <100000000>;
+	max-frequency = <200000000>;
 	disable-wp;
 	sd-uhs-sdr12;
 	sd-uhs-sdr25;
-- 
2.17.0
