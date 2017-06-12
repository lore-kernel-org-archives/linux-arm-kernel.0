From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 12 Jun 2017 10:28:13 +0900
Subject: Fwd: [PATCH] ARM: prima2: remove redundant select CPU_V7
In-Reply-To: <1488078449-3902-1-git-send-email-yamada.masahiro@socionext.com>
References: <1488078449-3902-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK7LNASAUDsBOLvmrKjX1+36HESg2SK3AE3e_18YaLF-8sQmPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,


It has been more than 3 months since this patch was posted,
but the maintainer of prima2 did not respond.
(I guess mach-prima2 is not maintained.)

This is a minor clean-up,
but could you consider picking it up to ARM-SOC tree?

Thanks,


---------- Forwarded message ----------
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: 2017-02-26 12:07 GMT+09:00
Subject: [PATCH] ARM: prima2: remove redundant select CPU_V7
To: linux-arm-kernel at lists.infradead.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Russell King
<linux@armlinux.org.uk>, Barry Song <baohua@kernel.org>,
linux-kernel at vger.kernel.org


ARCH_ATLAS7 resides in "if ARCH_SIRF ... end", and ARCH_SIRF depends
on ARCH_MULTI_V7, which selects CPU_V7.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/mach-prima2/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-prima2/Kconfig b/arch/arm/mach-prima2/Kconfig
index 85e874a..7426211 100644
--- a/arch/arm/mach-prima2/Kconfig
+++ b/arch/arm/mach-prima2/Kconfig
@@ -27,7 +27,6 @@ config ARCH_ATLAS7
        bool "CSR SiRFSoC ATLAS7 ARM Cortex A7 Platform"
        default y
        select ARM_GIC
-       select CPU_V7
        select ATLAS7_TIMER
        select HAVE_ARM_SCU if SMP
        select HAVE_SMP
--
2.7.4



-- 
Best Regards
Masahiro Yamada
