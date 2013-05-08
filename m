From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  8 May 2013 14:29:09 +0100
Subject: [PATCH 9/9] mfd: ab8500-core: Pass GPADC compatible string to MFD core
In-Reply-To: <1368019749-19455-1-git-send-email-lee.jones@linaro.org>
References: <1368019749-19455-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1368019749-19455-10-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When booting with Device Tree enabled the MFD core uses each device's
compatible string to find and allocate its associated of_node pointer,
which in turn is passed to the driver via the platform_device struct.
Without it, the driver won't be able to interrogate the Device Tree or
locate suitable regulators and will most likely fail to probe.

Cc: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/ab8500-core.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index 2047485..983eb1e 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -1060,6 +1060,7 @@ static struct mfd_cell ab8500_devs[] = {
 	},
 	{
 		.name = "ab8500-gpadc",
+		.of_compatible = "stericsson,ab8500-gpadc",
 		.num_resources = ARRAY_SIZE(ab8500_gpadc_resources),
 		.resources = ab8500_gpadc_resources,
 	},
@@ -1217,6 +1218,7 @@ static struct mfd_cell ab8505_devs[] = {
 	},
 	{
 		.name = "ab8500-gpadc",
+		.of_compatible = "stericsson,ab8500-gpadc",
 		.num_resources = ARRAY_SIZE(ab8505_gpadc_resources),
 		.resources = ab8505_gpadc_resources,
 	},
@@ -1280,6 +1282,7 @@ static struct mfd_cell ab8540_devs[] = {
 	},
 	{
 		.name = "ab8500-gpadc",
+		.of_compatible = "stericsson,ab8500-gpadc",
 		.num_resources = ARRAY_SIZE(ab8505_gpadc_resources),
 		.resources = ab8505_gpadc_resources,
 	},
-- 
1.7.10.4
