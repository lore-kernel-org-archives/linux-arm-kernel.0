From: labbott@redhat.com (Laura Abbott)
Date: Tue, 18 Apr 2017 11:27:14 -0700
Subject: [PATCHv4 12/12] staging/android: Update Ion TODO list
In-Reply-To: <1492540034-5466-1-git-send-email-labbott@redhat.com>
References: <1492540034-5466-1-git-send-email-labbott@redhat.com>
Message-ID: <1492540034-5466-13-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most of the items have been taken care of by a clean up series. Remove
the completed items and add a few new ones.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 drivers/staging/android/TODO | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/android/TODO b/drivers/staging/android/TODO
index 8f3ac37..5f14247 100644
--- a/drivers/staging/android/TODO
+++ b/drivers/staging/android/TODO
@@ -7,23 +7,10 @@ TODO:
 
 
 ion/
- - Remove ION_IOC_SYNC: Flushing for devices should be purely a kernel internal
-   interface on top of dma-buf. flush_for_device needs to be added to dma-buf
-   first.
- - Remove ION_IOC_CUSTOM: Atm used for cache flushing for cpu access in some
-   vendor trees. Should be replaced with an ioctl on the dma-buf to expose the
-   begin/end_cpu_access hooks to userspace.
- - Clarify the tricks ion plays with explicitly managing coherency behind the
-   dma api's back (this is absolutely needed for high-perf gpu drivers): Add an
-   explicit coherency management mode to flush_for_device to be used by drivers
-   which want to manage caches themselves and which indicates whether cpu caches
-   need flushing.
- - With those removed there's probably no use for ION_IOC_IMPORT anymore either
-   since ion would just be the central allocator for shared buffers.
- - Add dt-binding to expose cma regions as ion heaps, with the rule that any
-   such cma regions must already be used by some device for dma. I.e. ion only
-   exposes existing cma regions and doesn't reserve unecessarily memory when
-   booting a system which doesn't use ion.
+ - Add dt-bindings for remaining heaps (chunk and carveout heaps). This would
+   involve putting appropriate bindings in a memory node for Ion to find.
+ - Split /dev/ion up into multiple nodes (e.g. /dev/ion/heap0)
+ - Better test framework (integration with VGEM was suggested)
 
 Please send patches to Greg Kroah-Hartman <greg@kroah.com> and Cc:
 Arve Hj?nnev?g <arve@android.com> and Riley Andrews <riandrews@android.com>
-- 
2.7.4
