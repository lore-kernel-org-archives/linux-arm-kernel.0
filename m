From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Tue, 29 Oct 2013 17:50:02 +0530
Subject: [PATCH 1/4] mfd: as3722: add clock driver as mfd-sub device for the
 ams AS3722
In-Reply-To: <1383049205-29620-1-git-send-email-ldewangan@nvidia.com>
References: <1383049205-29620-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1383049205-29620-2-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Device ams AS3722 supports the one 32KHz clock output. The clock control
support is provided through clock driver.

Add clock driver as mfd sub device to probe the clock driver.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 Documentation/devicetree/bindings/mfd/as3722.txt |    9 +++++++++
 drivers/mfd/as3722.c                             |    3 +++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/as3722.txt b/Documentation/devicetree/bindings/mfd/as3722.txt
index fc2191e..e782f39 100644
--- a/Documentation/devicetree/bindings/mfd/as3722.txt
+++ b/Documentation/devicetree/bindings/mfd/as3722.txt
@@ -112,6 +112,15 @@ Following are properties of regulator subnode.
 		ams,enable-tracking: Enable tracking with SD1, only supported
 			by LDO3.
 
+Clock:
+======
+AS3722 supports one 32KHz clock to output from device. The clock control is
+provided through the clock driver.
+This binding uses the common clock binding ./clock-bindings.txt.
+The device node should have the optional properties to support the clock:
+#clock-cells: from common clock binding; shall be set to 1. The clock id for
+	single clock output is 0.
+
 Example:
 --------
 #include <dt-bindings/mfd/as3722.h>
diff --git a/drivers/mfd/as3722.c b/drivers/mfd/as3722.c
index f161f2e..1d3415c 100644
--- a/drivers/mfd/as3722.c
+++ b/drivers/mfd/as3722.c
@@ -72,6 +72,9 @@ static struct mfd_cell as3722_devs[] = {
 		.resources = as3722_adc_resource,
 	},
 	{
+		.name = "as3722-clk",
+	},
+	{
 		.name = "as3722-power-off",
 	},
 };
-- 
1.7.1.1
