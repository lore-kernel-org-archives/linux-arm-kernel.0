From: lkp@intel.com (kbuild test robot)
Date: Wed, 7 Oct 2015 05:29:32 +0800
Subject: [RFC PATCH] staging: ion: ion_parse_dt_heap_common() can be static
In-Reply-To: <1444164433-9107-3-git-send-email-labbott@fedoraproject.org>
References: <201510070535.v0amqMb0%fengguang.wu@intel.com>
Message-ID: <20151006212932.GA59274@xian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 ion_of.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/android/ion/ion_of.c b/drivers/staging/android/ion/ion_of.c
index 3c9b1e5..daded0c 100644
--- a/drivers/staging/android/ion/ion_of.c
+++ b/drivers/staging/android/ion/ion_of.c
@@ -28,7 +28,7 @@
  * Future work: allow callback function for each heap?
  */
 
-int ion_parse_dt_heap_common(struct device_node *heap_node,
+static int ion_parse_dt_heap_common(struct device_node *heap_node,
 			struct ion_platform_heap *heap)
 {
 	u32 ion_heap_id, ion_heap_align, ion_heap_type;
@@ -67,7 +67,7 @@ int ion_parse_dt_heap_common(struct device_node *heap_node,
 	return 0;
 }
 
-int ion_setup_heap_common(struct platform_device *parent,
+static int ion_setup_heap_common(struct platform_device *parent,
 			struct device_node *heap_node,
 			struct ion_platform_heap *heap)
 {
