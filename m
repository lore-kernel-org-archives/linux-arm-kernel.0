From: julien.grall@citrix.com (Julien Grall)
Date: Fri, 25 Sep 2015 15:51:00 +0100
Subject: [PATCH v1 1/8] xen/arm: io: remove mmio_check_t typedef
In-Reply-To: <1443192667-16112-1-git-send-email-julien.grall@citrix.com>
References: <1443192667-16112-1-git-send-email-julien.grall@citrix.com>
Message-ID: <1443192667-16112-2-git-send-email-julien.grall@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julien Grall <julien.grall@linaro.org>

This typedef is a left-over of the previous MMIO emulation
implementation.

Signed-off-by: Julien Grall <julien.grall@linaro.org>
---
    Changes in v2:
        - Patch added
---
 xen/include/asm-arm/mmio.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/xen/include/asm-arm/mmio.h b/xen/include/asm-arm/mmio.h
index 0160f09..7278bce 100644
--- a/xen/include/asm-arm/mmio.h
+++ b/xen/include/asm-arm/mmio.h
@@ -34,7 +34,6 @@ typedef struct
 
 typedef int (*mmio_read_t)(struct vcpu *v, mmio_info_t *info);
 typedef int (*mmio_write_t)(struct vcpu *v, mmio_info_t *info);
-typedef int (*mmio_check_t)(struct vcpu *v, paddr_t addr);
 
 struct mmio_handler_ops {
     mmio_read_t read_handler;
-- 
2.1.4
