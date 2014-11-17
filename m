From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 17 Nov 2014 20:30:20 +0000
Subject: [PATCH 8/8] ARM: io.c: clean up EXPORT_SYMBOL()s
In-Reply-To: <20141117202911.GZ4042@n2100.arm.linux.org.uk>
References: <20141117202911.GZ4042@n2100.arm.linux.org.uk>
Message-ID: <E1XqSwG-0002Ej-Rj@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Place EXPORT_SYMBOL()s after the function definition.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/io.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/io.c b/arch/arm/kernel/io.c
index 9203cf883330..eedefe050022 100644
--- a/arch/arm/kernel/io.c
+++ b/arch/arm/kernel/io.c
@@ -51,6 +51,7 @@ void _memcpy_fromio(void *to, const volatile void __iomem *from, size_t count)
 		from++;
 	}
 }
+EXPORT_SYMBOL(_memcpy_fromio);
 
 /*
  * Copy data from "real" memory space to IO memory space.
@@ -66,6 +67,7 @@ void _memcpy_toio(volatile void __iomem *to, const void *from, size_t count)
 		to++;
 	}
 }
+EXPORT_SYMBOL(_memcpy_toio);
 
 /*
  * "memset" on IO memory space.
@@ -79,7 +81,4 @@ void _memset_io(volatile void __iomem *dst, int c, size_t count)
 		dst++;
 	}
 }
-
-EXPORT_SYMBOL(_memcpy_fromio);
-EXPORT_SYMBOL(_memcpy_toio);
 EXPORT_SYMBOL(_memset_io);
-- 
1.8.3.1
