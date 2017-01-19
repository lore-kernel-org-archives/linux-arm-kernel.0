From: jonathan.richardson@broadcom.com (Jonathan Richardson)
Date: Wed, 18 Jan 2017 17:39:40 -0800
Subject: [PATCH v2 3/3] ARM: dts: Enable Broadcom iProc mailbox controller
In-Reply-To: <1484789980-6812-1-git-send-email-jonathan.richardson@broadcom.com>
References: <1484789980-6812-1-git-send-email-jonathan.richardson@broadcom.com>
Message-ID: <1484789980-6812-4-git-send-email-jonathan.richardson@broadcom.com>
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
 arch/arm/boot/dts/bcm-cygnus.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index fabc9f3..488bf42 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -114,6 +114,12 @@
 			      <0x0301d24c 0x2c>;
 		};
 
+		mailbox: mailbox at 03024024 {
+			compatible = "brcm,iproc-mailbox";
+			reg = <0x03024024 0x8>;
+			#mbox-cells = <1>;
+		};
+
 		gpio_crmu: gpio at 03024800 {
 			compatible = "brcm,cygnus-crmu-gpio";
 			reg = <0x03024800 0x50>,
-- 
1.9.1
