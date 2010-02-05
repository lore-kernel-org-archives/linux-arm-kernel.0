From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 4 Feb 2010 16:41:28 -0800
Subject: [PATCH 13/13] input: schedule corgi_ssp and corgi_ts to be removed
Message-ID: <mailman.196.1265367892.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Richard Purdie <rpurdie@rpsys.net>
Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 Documentation/feature-removal-schedule.txt |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/Documentation/feature-removal-schedule.txt
b/Documentation/feature-removal-schedule.txt
index 5860583..e16529e 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -554,3 +554,15 @@ Why:	We now have a generic GPIO based matrix
keyboard driver that
 	and so are difficult to maintain.
 Who:	Eric Miao <eric.y.miao@gmail.com>

+----------------------------
+
+What:	corgi_ssp and corgi_ts driver
+When:	2.6.35
+Files:	arch/arm/mach-pxa/corgi_ssp.c, drivers/input/touchscreen/corgi_ts.c
+Why:	The corgi touchscreen is now deprecated in favour of the generic
+	ads7846.c driver. The noise reduction technique used in corgi_ts.c
+	that's to wait til vsync before ADC sampling is also integrated into
+	ads7846 driver now. Provided that the original driver is not generic
+	and difficult to maintain, it will be removed later.
+Who:	Eric Miao <eric.y.miao@gmail.com>
+
--=20
1.6.3.3
