From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 16 Aug 2012 16:36:11 +0100
Subject: [PATCH v3 19/25] xen/arm: compile blkfront and blkback
In-Reply-To: <alpine.DEB.2.02.1208161618550.4850@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1208161618550.4850@kaball.uk.xensource.com>
Message-ID: <1345131377-14713-19-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 drivers/block/xen-blkback/blkback.c  |    1 +
 include/xen/interface/io/protocols.h |    3 +++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index 73f196c..63dd5b9 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -42,6 +42,7 @@
 
 #include <xen/events.h>
 #include <xen/page.h>
+#include <xen/xen.h>
 #include <asm/xen/hypervisor.h>
 #include <asm/xen/hypercall.h>
 #include "common.h"
diff --git a/include/xen/interface/io/protocols.h b/include/xen/interface/io/protocols.h
index 01fc8ae..0eafaf2 100644
--- a/include/xen/interface/io/protocols.h
+++ b/include/xen/interface/io/protocols.h
@@ -5,6 +5,7 @@
 #define XEN_IO_PROTO_ABI_X86_64     "x86_64-abi"
 #define XEN_IO_PROTO_ABI_IA64       "ia64-abi"
 #define XEN_IO_PROTO_ABI_POWERPC64  "powerpc64-abi"
+#define XEN_IO_PROTO_ABI_ARM        "arm-abi"
 
 #if defined(__i386__)
 # define XEN_IO_PROTO_ABI_NATIVE XEN_IO_PROTO_ABI_X86_32
@@ -14,6 +15,8 @@
 # define XEN_IO_PROTO_ABI_NATIVE XEN_IO_PROTO_ABI_IA64
 #elif defined(__powerpc64__)
 # define XEN_IO_PROTO_ABI_NATIVE XEN_IO_PROTO_ABI_POWERPC64
+#elif defined(__arm__)
+# define XEN_IO_PROTO_ABI_NATIVE XEN_IO_PROTO_ABI_ARM
 #else
 # error arch fixup needed here
 #endif
-- 
1.7.2.5
