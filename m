From: vincenzo.frascino@arm.com (Vincenzo Frascino)
Date: Fri,  9 Nov 2018 12:37:27 +0000
Subject: [PATCH 24/27] mips: Introduce vdso_direct
In-Reply-To: <20181109123730.8743-1-vincenzo.frascino@arm.com>
References: <20181109123730.8743-1-vincenzo.frascino@arm.com>
Message-ID: <20181109123730.8743-25-vincenzo.frascino@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

vdso_direct is an architectural clock configuration parameter that
exposes the usage of not of the vDSO.

If vdso_direct is false, the time related syscalls will be used instead
of the vDSO library.

This patch introduces the parameter in the mips architecture to prepare
the ground for the support of the generic vDSO library.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/mips/include/asm/clocksource.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/include/asm/clocksource.h b/arch/mips/include/asm/clocksource.h
index 3deb1d0c1a94..eab11ee4871a 100644
--- a/arch/mips/include/asm/clocksource.h
+++ b/arch/mips/include/asm/clocksource.h
@@ -23,6 +23,7 @@
  * @vdso_clock_mode: Method the VDSO should use to access the clocksource.
  */
 struct arch_clocksource_data {
+	bool vdso_direct;
 	u8 vdso_clock_mode;
 };
 
-- 
2.19.1
