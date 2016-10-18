From: jonathan.richardson@broadcom.com (Jonathan Richardson)
Date: Tue, 18 Oct 2016 12:00:37 -0700
Subject: [PATCH v1 3/4] ARM: dts: Enable Broadcom iProc mailbox controller
In-Reply-To: <1476817238-1226-1-git-send-email-jonathan.richardson@broadcom.com>
References: <1476817238-1226-1-git-send-email-jonathan.richardson@broadcom.com>
Message-ID: <1476817238-1226-4-git-send-email-jonathan.richardson@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reviewed-by: Jonathan Richardson <jonathan.richardson@broadcom.com>
Reviewed-by: Shreesha Rajashekar <shreesha.rajashekar@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Tested-by: Jonathan Richardson <jonathan.richardson@broadcom.com>
Reviewed-by: Vikram Prakash <vikram.prakash@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Jonathan Richardson <jonathan.richardson@broadcom.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index fabc9f3..f873b74 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -114,6 +114,15 @@
 			      <0x0301d24c 0x2c>;
 		};
 
+		mailbox: mailbox at 03024024 {
+			compatible = "brcm,iproc-mailbox";
+			reg = <0x03024024 0x40>;
+			interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			#mbox-cells = <1>;
+		};
+
 		gpio_crmu: gpio at 03024800 {
 			compatible = "brcm,cygnus-crmu-gpio";
 			reg = <0x03024800 0x50>,
-- 
1.9.1
