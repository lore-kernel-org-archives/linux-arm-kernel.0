From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 13 Aug 2014 14:01:43 +0200
Subject: [PATCH] ARM: zynq: cpuidle: Remove .owner field for driver
Message-ID: <01b4472cb5b1a5d03c98ec78cdd223970a52bd54.1407931299.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no need to init .owner field.

Based on the patch from Peter Griffin <peter.griffin@linaro.org>
"mmc: remove .owner field for drivers using module_platform_driver"

This patch removes the superflous .owner field for drivers which
use the module_platform_driver API, as this is overriden in
platform_driver_register anyway."

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/cpuidle/cpuidle-zynq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-zynq.c b/drivers/cpuidle/cpuidle-zynq.c
index aded75928028..6e03734e3508 100644
--- a/drivers/cpuidle/cpuidle-zynq.c
+++ b/drivers/cpuidle/cpuidle-zynq.c
@@ -80,7 +80,6 @@ static int zynq_cpuidle_probe(struct platform_device *pdev)
 static struct platform_driver zynq_cpuidle_driver = {
 	.driver = {
 		.name = "cpuidle-zynq",
-		.owner = THIS_MODULE,
 	},
 	.probe = zynq_cpuidle_probe,
 };
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140813/edd1941d/attachment.sig>
