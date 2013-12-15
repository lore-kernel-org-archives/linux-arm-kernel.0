From: dt.tangr@gmail.com (dt.tangr at gmail.com)
Date: Sun, 15 Dec 2013 20:54:12 +1100
Subject: [PATCH 2/3] arm: nspire: modify device tree to use the LSI Zevio LED
 driver
In-Reply-To: <1387101253-30804-1-git-send-email-dt.tangr@gmail.com>
References: <1387101253-30804-1-git-send-email-dt.tangr@gmail.com>
Message-ID: <1387101253-30804-2-git-send-email-dt.tangr@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Daniel Tang <dt.tangr@gmail.com>


Signed-off-by: Daniel Tang <dt.tangr@gmail.com>
---
 arch/arm/boot/dts/nspire.dtsi |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nspire.dtsi b/arch/arm/boot/dts/nspire.dtsi
index a22ffe6..bb453bb 100644
--- a/arch/arm/boot/dts/nspire.dtsi
+++ b/arch/arm/boot/dts/nspire.dtsi
@@ -167,8 +167,9 @@
 				reg = <0x900F0000 0x1000>;
 			};
 
-			led: led at 90110000 {
-				reg = <0x90110000 0x1000>;
+			led: led at 90110B00 {
+				compatible = "lsi,zevio-led";
+				reg = <0x90110B00 0x100>;
 			};
 		};
 	};
-- 
1.7.10.4
