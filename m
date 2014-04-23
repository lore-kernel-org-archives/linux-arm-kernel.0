From: mporter@linaro.org (Matt Porter)
Date: Wed, 23 Apr 2014 19:21:30 -0400
Subject: [PATCH v2 1/4] mfd: bcm590xx: update binding with additional BCM59056
 regulators
In-Reply-To: <1398295293-11033-1-git-send-email-mporter@linaro.org>
References: <1398295293-11033-1-git-send-email-mporter@linaro.org>
Message-ID: <1398295293-11033-2-git-send-email-mporter@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The BCM59056 supports GPLDO1-6 and VBUS regulators in a secondary
I2C slave address space. Add these regulators to the list of valid
regulator node names for BCM59056.

Signed-off-by: Matt Porter <mporter@linaro.org>
---
 Documentation/devicetree/bindings/mfd/bcm590xx.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/bcm590xx.txt b/Documentation/devicetree/bindings/mfd/bcm590xx.txt
index 1fe30e2..be51a15 100644
--- a/Documentation/devicetree/bindings/mfd/bcm590xx.txt
+++ b/Documentation/devicetree/bindings/mfd/bcm590xx.txt
@@ -19,7 +19,9 @@ Optional child nodes:
   The valid regulator node names for BCM59056 are:
   	rfldo, camldo1, camldo2, simldo1, simldo2, sdldo, sdxldo,
 	mmcldo1, mmcldo2, audldo, micldo, usbldo, vibldo,
-	csr, iosr1, iosr2, msr, sdsr1, sdsr2, vsr
+	csr, iosr1, iosr2, msr, sdsr1, sdsr2, vsr,
+	gpldo1, gpldo2, gpldo3, gpldo4, gpldo5, gpldo6,
+	vbus
 
 Example:
 	pmu: bcm59056 at 8 {
-- 
1.8.4
