From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 Jan 2014 21:57:15 +0100
Subject: [PATCH 09/20] ARM64 / ACPI: Implement core functions for parsing
 MADT table
In-Reply-To: <52E287EE.70407@linaro.org>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
 <52E15756.4060705@arm.com> <52E287EE.70407@linaro.org>
Message-ID: <201401242157.15495.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 24 January 2014, Hanjun Guo wrote:
> >> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> >> index e108d9c..c335c6d 100644
> >> --- a/arch/arm64/include/asm/acpi.h
> >> +++ b/arch/arm64/include/asm/acpi.h
> >> @@ -83,6 +83,9 @@ void arch_fix_phys_package_id(int num, u32 slot);
> >>   extern int (*acpi_suspend_lowlevel)(void);
> >>   #define acpi_wakeup_address (0)
> >>   
> >> +#define MAX_GIC_CPU_INTERFACE 256
> > I'll bite. Where on Earth is this value coming from?
> 
> I just thought 256 is big enough for now :(
> Yes, should be a larger number for GICv3.

Could this just be set to NR_CPUS? That way it will be large enough for
any system you can actually run on.

	Arnd
