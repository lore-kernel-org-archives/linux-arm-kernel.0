From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 26 Jun 2013 10:51:13 +0200
Subject: [PATCH 4/4] arm: mxs: Add mxs internal temp sensor to cfa-10036
In-Reply-To: <1372236673-20725-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1372236673-20725-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1372236673-20725-5-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/imx28-cfa10036.dts | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx28-cfa10036.dts b/arch/arm/boot/dts/imx28-cfa10036.dts
index 802e0e9..5afb945 100644
--- a/arch/arm/boot/dts/imx28-cfa10036.dts
+++ b/arch/arm/boot/dts/imx28-cfa10036.dts
@@ -95,7 +95,7 @@
 				status = "okay";
 			};
 
-			lradc at 80050000 {
+			lradc: lradc at 80050000 {
 				status = "okay";
 			};
 		};
@@ -121,4 +121,10 @@
 			default-state = "on";
 		};
 	};
+
+	temp {
+		compatible = "fsl,mxs-internal-temp";
+		io-channels = <&lradc 8>, <&lradc 9>;
+		io-channel-names = "min", "max";
+	};
 };
-- 
1.8.1.2
