From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 8 Feb 2013 15:14:35 -0200
Subject: mx28evk does not boot with linux-next 20130207
In-Reply-To: <20130208164858.GA32318@mudshark.cambridge.arm.com>
References: <CAOMZO5Ar1T3Lg2KRvSLK-gjNAaAFAf39f6KqaYeF03w5bNj6EQ@mail.gmail.com>
 <20130207125801.GA19091@S2101-09.ap.freescale.net>
 <CAOMZO5D5ipAF0JOUOFezGz4Zr66M4bRm819ZurAfwPOrduBo5w@mail.gmail.com>
 <20130208161811.GW17833@n2100.arm.linux.org.uk>
 <20130208164858.GA32318@mudshark.cambridge.arm.com>
Message-ID: <CAOMZO5CbJfpVwqHM1RSYdEQH4n1EL67Kt2_tC9TNPxZGMsPevQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 8, 2013 at 2:48 PM, Will Deacon <will.deacon@arm.com> wrote:

> From dc381a5dff9663901a61fe0dd86c986add382281 Mon Sep 17 00:00:00 2001
> From: Will Deacon <will.deacon@arm.com>
> Date: Fri, 8 Feb 2013 16:41:19 +0000
> Subject: [PATCH] ARM: tlb: fix branch predictor maintenance for ARMv6
>
> The BPIALL operation is not available on all CPUs, so ensure that we
> only execute it on processors implementing the instruction.
>
> Reported-by: Fabio Estevam <festevam@gmail.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Thanks, Will.

This makes the kernel to boot again on my mx28evk, so:

Tested-by: Fabio Estevam <fabio.estevam@freescale.com>

There are still other issues, which seem to be unrelated to this fix though:

I can see the Linux logo and LED activity on my board, but no serial console.

Applying Shawn's patch:

diff --git a/arch/arm/boot/compressed/debug.S
b/arch/arm/boot/compressed/debug.S
index bdb0e25..6e8382d 100644
--- a/arch/arm/boot/compressed/debug.S
+++ b/arch/arm/boot/compressed/debug.S
@@ -1,4 +1,5 @@
 #include <linux/linkage.h>
+#include <asm/assembler.h>

 #include CONFIG_DEBUG_LL_INCLUDE

and turning on earlyprintk I see kernel booting and it stops at:

[    5.311281] TCP: cubic registered
[    5.315000] NET: Registered protocol family 17
[    5.320843] Key type dns_resolver registered
[    5.325750] turn off boot console earlycon0

Regards,

Fabio Estevam
