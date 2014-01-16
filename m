From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 16 Jan 2014 17:08:23 +0100
Subject: [PATCH v2] ARM: dts: tps65910 backup battery regulator
In-Reply-To: <1387539808-24910-3-git-send-email-mpa@pengutronix.de>
References: <1387539808-24910-3-git-send-email-mpa@pengutronix.de>
Message-ID: <1389888503-32013-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a devicetree node for the backup battery regulator.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
Hi,

Mark Brown applied [1] the other part of the series which adds 'vbb' as
regulator-compatible. I forgot to add you in Cc.

Regards,

Markus

[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/289815/focus=290089

 arch/arm/boot/dts/tps65910.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/tps65910.dtsi b/arch/arm/boot/dts/tps65910.dtsi
index 92693a8..b0ac665 100644
--- a/arch/arm/boot/dts/tps65910.dtsi
+++ b/arch/arm/boot/dts/tps65910.dtsi
@@ -82,5 +82,10 @@
 			reg = <12>;
 			regulator-compatible = "vmmc";
 		};
+
+		vbb_reg: regulator at 13 {
+			reg = <13>;
+			regulator-compatible = "vbb";
+		};
 	};
 };
-- 
1.8.5.2
