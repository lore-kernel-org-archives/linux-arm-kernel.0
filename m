From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri,  2 Dec 2016 14:48:13 +0100
Subject: [RESEND PATCH v2 7/7] ARM: bcm/dt: Enable the VEC IP on all
 RaspberryPi boards
In-Reply-To: <1480686493-4813-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1480686493-4813-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1480686493-4813-8-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the VEC IP on all RaspberryPi boards.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/bcm2835-rpi.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index e9b47b2bbc33..8893240da5f6 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -84,3 +84,8 @@
 	power-domains = <&power RPI_POWER_DOMAIN_HDMI>;
 	status = "okay";
 };
+
+&vec {
+	power-domains = <&power RPI_POWER_DOMAIN_VEC>;
+	status = "okay";
+};
-- 
2.7.4
