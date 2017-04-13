From: robh@kernel.org (Rob Herring)
Date: Thu, 13 Apr 2017 10:03:53 -0500
Subject: [PATCH v3 4/4] arm64: dts: hikey: add WL1835 Bluetooth device node
In-Reply-To: <20170413150353.7389-1-robh@kernel.org>
References: <20170413150353.7389-1-robh@kernel.org>
Message-ID: <20170413150353.7389-5-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the serial slave device for the WL1835 Bluetooth interface.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: Mark Rutland <mark.rutland@arm.com>
---
v3:
- rebase on bluetooth-next

 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index dba3c131c62c..9b4ba7169210 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -98,6 +98,11 @@
 			assigned-clocks = <&sys_ctrl HI6220_UART1_SRC>;
 			assigned-clock-rates = <150000000>;
 			status = "ok";
+
+			bluetooth {
+				compatible = "ti,wl1835-st";
+				enable-gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
+			};
 		};
 
 		uart2: uart at f7112000 {
-- 
2.11.0
