From: sebastien.bourdelin@savoirfairelinux.com (Sebastien Bourdelin)
Date: Fri, 14 Jul 2017 16:08:53 -0400
Subject: [PATCH v4 8/8] ARM: dts: TS-4600: add watchdog support
In-Reply-To: <20170714200853.10362-1-sebastien.bourdelin@savoirfairelinux.com>
References: <20170714200853.10362-1-sebastien.bourdelin@savoirfairelinux.com>
Message-ID: <20170714200853.10362-9-sebastien.bourdelin@savoirfairelinux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables support for the watchdog located in the FPGA.

Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
---
 arch/arm/boot/dts/imx28-ts4600-common.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx28-ts4600-common.dtsi b/arch/arm/boot/dts/imx28-ts4600-common.dtsi
index a90bd934e4a3..9e177d33ba9c 100644
--- a/arch/arm/boot/dts/imx28-ts4600-common.dtsi
+++ b/arch/arm/boot/dts/imx28-ts4600-common.dtsi
@@ -116,6 +116,11 @@
 		ts,strobe-gpios = <&gpio0 25 GPIO_ACTIVE_HIGH>;
 		ts,ale-gpios    = <&gpio0 26 GPIO_ACTIVE_HIGH>;
 		ts,rdy-gpios    = <&gpio0 21 GPIO_ACTIVE_HIGH>;
+
+		watchdog at 2a {
+			compatible = "technologic,ts4600-wdt";
+			reg = <0x2a>;
+		};
 	};
 
 };
-- 
2.13.0
