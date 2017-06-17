From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 16 Jun 2017 17:07:43 -0700
Subject: [PATCH v3 3/4] arm64: Provide a fncpy implementation
In-Reply-To: <20170617000744.22158-1-f.fainelli@gmail.com>
References: <20170617000744.22158-1-f.fainelli@gmail.com>
Message-ID: <20170617000744.22158-4-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Utilize the asm-generic/fncpy.h implementation for ARM64 to allow the
use of drivers/misc/sram*.c on these platforms as well.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm64/include/asm/Kbuild | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
index a7a97a608033..5cfd822d3256 100644
--- a/arch/arm64/include/asm/Kbuild
+++ b/arch/arm64/include/asm/Kbuild
@@ -7,6 +7,7 @@ generic-y += dma-contiguous.h
 generic-y += early_ioremap.h
 generic-y += emergency-restart.h
 generic-y += errno.h
+generic-y += fncpy.h
 generic-y += hw_irq.h
 generic-y += ioctl.h
 generic-y += ioctls.h
-- 
2.9.3
