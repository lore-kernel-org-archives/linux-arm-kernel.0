From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri,  6 Dec 2013 21:47:23 +0100
Subject: [PATCH] ARM: dts: mxs: Add iio-hwmon to crystalfontz boards
Message-ID: <1386362843-20798-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---

This won't work until those patches are applied:
 https://lkml.org/lkml/2013/12/6/676
 and http://lists.infradead.org/pipermail/linux-arm-kernel/2013-December/216963.html

However, I'm wondering if it wouldn't make sense to add it directly in
imx28.dtsi

 arch/arm/boot/dts/imx28-cfa10036.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx28-cfa10036.dts b/arch/arm/boot/dts/imx28-cfa10036.dts
index cabb6171a19d..51ebf36dd7b9 100644
--- a/arch/arm/boot/dts/imx28-cfa10036.dts
+++ b/arch/arm/boot/dts/imx28-cfa10036.dts
@@ -114,4 +114,9 @@
 			default-state = "on";
 		};
 	};
+
+	iio_hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&lradc 8>;
+	};
 };
-- 
1.8.3.2
