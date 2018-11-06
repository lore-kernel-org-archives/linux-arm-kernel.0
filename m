From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 06 Nov 2018 13:40:25 +0000
Subject: [PATCH 4/4] ARM: enable LD_DEAD_CODE_DATA_ELIMINATION
In-Reply-To: <20181106133935.GB30658@n2100.armlinux.org.uk>
References: <20181106133935.GB30658@n2100.armlinux.org.uk>
Message-ID: <E1gK1aj-0000p7-Ic@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable LD_DEAD_CODE_DATA_ELIMINATION, which allows functions that are
not called to be eliminated from the final kernel image.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 91be74d8df65..f7f65d0d5a05 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -82,6 +82,7 @@ config ARM
 	select HAVE_KERNEL_XZ
 	select HAVE_KPROBES if !XIP_KERNEL && !CPU_ENDIAN_BE32 && !CPU_V7M
 	select HAVE_KRETPROBES if (HAVE_KPROBES)
+	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if !FUNCTION_TRACER
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_NMI
 	select HAVE_OPROFILE if (HAVE_PERF_EVENTS)
-- 
2.7.4
