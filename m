From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Tue, 14 Mar 2017 08:58:30 +0100
Subject: [PATCH 2/2] ARM: dts: BCM53573: Specify serial console parameters
In-Reply-To: <20170314075830.2247-1-zajec5@gmail.com>
References: <20170314075830.2247-1-zajec5@gmail.com>
Message-ID: <20170314075830.2247-2-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafa? Mi?ecki <rafal@milecki.pl>

This adds baud rate, parity & number of data bits. It's required to get
serial working correctly.

Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
---
 arch/arm/boot/dts/bcm53573.dtsi | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm53573.dtsi b/arch/arm/boot/dts/bcm53573.dtsi
index 71ce23e46d30..eae623f76401 100644
--- a/arch/arm/boot/dts/bcm53573.dtsi
+++ b/arch/arm/boot/dts/bcm53573.dtsi
@@ -13,8 +13,12 @@
 / {
 	interrupt-parent = <&gic>;
 
+	aliases {
+		serial0 = &uart0;
+	};
+
 	chosen {
-		stdout-path = &uart0;
+		stdout-path = "serial0:115200n8";
 	};
 
 	cpus {
-- 
2.11.0
