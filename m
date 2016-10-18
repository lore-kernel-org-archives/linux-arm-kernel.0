From: jonathan.richardson@broadcom.com (Jonathan Richardson)
Date: Tue, 18 Oct 2016 12:00:38 -0700
Subject: [PATCH v1 4/4] ARM: dts: Enable interrupt support for cygnus crmu
 gpio driver
In-Reply-To: <1476817238-1226-1-git-send-email-jonathan.richardson@broadcom.com>
References: <1476817238-1226-1-git-send-email-jonathan.richardson@broadcom.com>
Message-ID: <1476817238-1226-5-git-send-email-jonathan.richardson@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The M0 processor handles interrupts for the always-on CRMU GPIO
controller. Setting the CRMU GPIO driver with the mailbox controller as
the interrupt parent allows the mailbox controller to forward interrupts
from the M0 to the GPIO driver for processing.

Reviewed-by: Jonathan Richardson <jonathan.richardson@broadcom.com>
Tested-by: Jonathan Richardson <jonathan.richardson@broadcom.com>
Reviewed-by: Vikram Prakash <vikram.prakash@broadcom.com>
Reviewed-by: Shreesha Rajashekar <shreesha.rajashekar@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Jonathan Richardson <jonathan.richardson@broadcom.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index f873b74..8b046a8 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -130,6 +130,9 @@
 			ngpios = <6>;
 			#gpio-cells = <2>;
 			gpio-controller;
+			interrupt-controller;
+			interrupt-parent = <&mailbox>;
+			interrupts = <0>;
 		};
 
 		i2c0: i2c at 18008000 {
-- 
1.9.1
