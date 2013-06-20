From: joelagnel@ti.com (Joel A Fernandes)
Date: Thu, 20 Jun 2013 16:06:43 -0500
Subject: [PATCH v12 07/11] ARM: davinci: Fix compiler warnings in devices-da8xx
In-Reply-To: <1371762407-24544-1-git-send-email-joelagnel@ti.com>
References: <1371762407-24544-1-git-send-email-joelagnel@ti.com>
Message-ID: <1371762407-24544-8-git-send-email-joelagnel@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joel A Fernandes <agnel.joel@gmail.com>

queue_priority_mapping and queue_tc_mapping are no longer
const anymore generating a bunch of warnings in devices-da8xx.
Fix them by not doing constant assignments.

Signed-off-by: Joel A Fernandes <joelagnel@ti.com>
---
 arch/arm/mach-davinci/devices-da8xx.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index bf57252..eb254fe 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -105,27 +105,27 @@ struct platform_device da8xx_serial_device = {
 	},
 };
 
-static const s8 da8xx_queue_tc_mapping[][2] = {
+static s8 da8xx_queue_tc_mapping[][2] = {
 	/* {event queue no, TC no} */
 	{0, 0},
 	{1, 1},
 	{-1, -1}
 };
 
-static const s8 da8xx_queue_priority_mapping[][2] = {
+static s8 da8xx_queue_priority_mapping[][2] = {
 	/* {event queue no, Priority} */
 	{0, 3},
 	{1, 7},
 	{-1, -1}
 };
 
-static const s8 da850_queue_tc_mapping[][2] = {
+static s8 da850_queue_tc_mapping[][2] = {
 	/* {event queue no, TC no} */
 	{0, 0},
 	{-1, -1}
 };
 
-static const s8 da850_queue_priority_mapping[][2] = {
+static s8 da850_queue_priority_mapping[][2] = {
 	/* {event queue no, Priority} */
 	{0, 3},
 	{-1, -1}
-- 
1.7.9.5
