From: b29396@freescale.com (Dong Aisheng)
Date: Wed, 30 Oct 2013 22:09:50 +0800
Subject: [PATCH v2 3/6] ARM: dts: sabresd: add usdhc4 support
In-Reply-To: <1383142193-24950-1-git-send-email-b29396@freescale.com>
References: <1383142193-24950-1-git-send-email-b29396@freescale.com>
Message-ID: <1383142193-24950-4-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add usdhc4 support which has an eMMC card mounted on board.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 39eafc2..76762a3 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -241,3 +241,12 @@
 	wp-gpios = <&gpio2 1 0>;
 	status = "okay";
 };
+
+&usdhc4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc4_1>;
+	bus-width = <8>;
+	non-removable;
+	no-1-8-v;
+	status = "okay";
+};
-- 
1.7.2.rc3
