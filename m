From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 4 Jan 2010 15:52:31 +0800
Subject: [ARM] pxa: fix compiler warnings of unused variable 'id' in
	cpu_is_pxa9*()
Message-ID: <f17812d71001032352gec110bak2e0157f0d5cc89be@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 0dfc84c9f54d8784f5bc6d303c079d88000ee5f7
Author: Eric Miao <eric.y.miao@gmail.com>
Date:   Mon Jan 4 14:44:42 2010 +0800

    [ARM] pxa: fix compiler warnings of unused variable 'id' in cpu_is_pxa9*()

    Signed-off-by: Eric Miao <eric.y.miao@gmail.com>

diff --git a/arch/arm/mach-pxa/include/mach/hardware.h
b/arch/arm/mach-pxa/include/mach/hardware.h
index 50f1297..e741bf1 100644
--- a/arch/arm/mach-pxa/include/mach/hardware.h
+++ b/arch/arm/mach-pxa/include/mach/hardware.h
@@ -250,20 +250,17 @@

 #define cpu_is_pxa930()					\
 	({						\
-		unsigned int id = read_cpuid(CPUID_ID);	\
-		__cpu_is_pxa930(id);			\
+		__cpu_is_pxa930(read_cpuid_id());	\
 	 })

 #define cpu_is_pxa935()					\
 	({						\
-		unsigned int id = read_cpuid(CPUID_ID);	\
-		__cpu_is_pxa935(id);			\
+		__cpu_is_pxa935(read_cpuid_id());	\
 	 })

 #define cpu_is_pxa950()					\
 	({						\
-		unsigned int id = read_cpuid(CPUID_ID);	\
-		__cpu_is_pxa950(id);			\
+		__cpu_is_pxa950(read_cpuid_id());	\
 	 })
