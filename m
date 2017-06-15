From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 15 Jun 2017 16:21:16 -0700
Subject: [PATCH 2/3] arm64: Provide a fncpy implenentation
In-Reply-To: <20170615232117.29727-1-f.fainelli@gmail.com>
References: <20170615232117.29727-1-f.fainelli@gmail.com>
Message-ID: <20170615232117.29727-3-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Utilize the asm-generic/fncpy.h implementation for ARM64 to allow the
use of drivers/misc/sram*.c on these platforms as well.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm64/include/asm/fncpy.h | 6 ++++++
 1 file changed, 6 insertions(+)
 create mode 100644 arch/arm64/include/asm/fncpy.h

diff --git a/arch/arm64/include/asm/fncpy.h b/arch/arm64/include/asm/fncpy.h
new file mode 100644
index 000000000000..578f942f55e4
--- /dev/null
+++ b/arch/arm64/include/asm/fncpy.h
@@ -0,0 +1,6 @@
+#ifndef __ASMARM64_FNCPY_H
+#define __ASMARM64_FNCPY_H
+
+#include <asm-generic/fncpy.h>
+
+#endif /* __ASMARM64_FNCPY_H */
-- 
2.9.3
