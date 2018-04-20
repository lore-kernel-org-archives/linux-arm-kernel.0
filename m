From: jan.tuerk@emtrion.com (jan.tuerk at emtrion.com)
Date: Fri, 20 Apr 2018 14:50:49 +0200
Subject: [PATCH v3 2/6] drm/panel: Add support for the EDT ETM0700G0EDH6
In-Reply-To: <20180420125108.14197-1-jan.tuerk@emtrion.com>
References: <20171220134710.64479-2-jan.tuerk@emtrion.com>
 <20180420125108.14197-1-jan.tuerk@emtrion.com>
Message-ID: <20180420125108.14197-3-jan.tuerk@emtrion.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jan Tuerk <jan.tuerk@emtrion.com>

The Emerging Display Technology ETM0700G0EDH6 is the
uses the same panel as the ETM0700G0BDH6. It differs
in the hardware design for the backlight and the
touchscreen i2c interface. As the new display type has
different requirements for drive-strengths on the i2c-bus,
add an additional compatible to allow the handling of it or warn
about incompatible cpu and display combinations.

Signed-off-by: Jan Tuerk <jan.tuerk@emtrion.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 8b7feb2888f2..2eed60134fa3 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2149,6 +2149,9 @@ static const struct of_device_id platform_of_match[] = {
 		.compatible = "edt,etm0700g0bdh6",
 		.data = &edt_etm0700g0bdh6,
 	}, {
+		.compatible = "edt,etm0700g0edh6",
+		.data = &edt_etm0700g0bdh6,
+	}, {
 		.compatible = "foxlink,fl500wvr00-a0t",
 		.data = &foxlink_fl500wvr00_a0t,
 	}, {
-- 
2.11.0
