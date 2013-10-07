From: syin@broadcom.com (Sherman Yin)
Date: Mon, 7 Oct 2013 12:28:28 -0700
Subject: [PATCH v2 4/4] pinctrl: Enable pinctrl for Broadcom Capri SoCs
In-Reply-To: <1381174108-25168-1-git-send-email-syin@broadcom.com>
References: <1380846199-12829-1-git-send-email-syin@broadcom.com>
 <1381174108-25168-1-git-send-email-syin@broadcom.com>
Message-ID: <1381174108-25168-5-git-send-email-syin@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable pinctrl for Broadcom Capri (BCM281xx) SoCs.

Signed-off-by: Sherman Yin <syin@broadcom.com>
Reviewed-by: Christian Daudt <bcm@fixthebug.org>
Reviewed-by: Matt Porter <matt.porter@linaro.org>
---
v2: Use hyphens instead of underscore in DT property names.
---
 arch/arm/boot/dts/bcm11351.dtsi |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
index 05a5aab..f497a40 100644
--- a/arch/arm/boot/dts/bcm11351.dtsi
+++ b/arch/arm/boot/dts/bcm11351.dtsi
@@ -96,4 +96,8 @@
 		status = "disabled";
 	};
 
+	pinctrl at 35004800 {
+		compatible = "brcm,capri-pinctrl";
+		reg = <0x35004800 0x430>;
+	};
 };
-- 
1.7.9.5
