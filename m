From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 19 Jul 2010 12:59:03 +0200
Subject: [PATCH 8/9] [ARM] mmp: avoid devices.h being included multiple times
In-Reply-To: <1279537144-25424-1-git-send-email-eric.y.miao@gmail.com>
References: <1279537144-25424-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <1279537144-25424-8-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-mmp/include/mach/devices.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mmp/include/mach/devices.h b/arch/arm/mach-mmp/include/mach/devices.h
index 1fa0a49..d0ec7da 100644
--- a/arch/arm/mach-mmp/include/mach/devices.h
+++ b/arch/arm/mach-mmp/include/mach/devices.h
@@ -1,3 +1,6 @@
+#ifndef __MACH_DEVICE_H
+#define __MACH_DEVICE_H
+
 #include <linux/types.h>
 
 #define MAX_RESOURCE_DMA	2
@@ -47,3 +50,4 @@ struct pxa_device_desc mmp2_device_##_name __initdata = {		\
 }
 
 extern int pxa_register_device(struct pxa_device_desc *, void *, size_t);
+#endif /* __MACH_DEVICE_H */
-- 
1.7.1
