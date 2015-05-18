From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 18 May 2015 18:45:17 +0100
Subject: [PATCHv2 11/12] ARM: migrate to common PSCI client code
In-Reply-To: <1431945503-6939-12-git-send-email-mark.rutland@arm.com>
References: <1431945503-6939-1-git-send-email-mark.rutland@arm.com>
 <1431945503-6939-12-git-send-email-mark.rutland@arm.com>
Message-ID: <20150518174517.GR21251@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 18, 2015 at 11:38:22AM +0100, Mark Rutland wrote:
> Now that the common PSCI client code has been factored out to
> drivers/firmware, and made safe for 32-bit use, move the 32-bit ARM code
> over to it. This results in a moderate reduction of duplicated lines,
> and will prevent further duplication as the PSCI client code is updated
> for PSCI 1.0 and beyond.
> 
> The two legacy platform users of the PSCI invocation code are updated to
> account for interface changes. In both cases the power state parameter
> is changed to an opaque u32 token in preparation for PSCI 1.0 power
> state changes.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/Kconfig                  |   1 +
>  arch/arm/include/asm/psci.h       |  23 ---
>  arch/arm/kernel/Makefile          |   2 +-
>  arch/arm/kernel/psci.c            | 299 --------------------------------------
>  arch/arm/kernel/psci_smp.c        |  29 +++-
>  arch/arm/kernel/setup.c           |   3 +-
>  arch/arm/mach-highbank/highbank.c |   2 +-
>  arch/arm/mach-highbank/pm.c       |   8 +-
>  drivers/cpuidle/cpuidle-calxeda.c |   7 +-
>  9 files changed, 32 insertions(+), 342 deletions(-)
>  delete mode 100644 arch/arm/kernel/psci.c

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

However, you need to get an ack from Russell. I assume you'll post this
again cc'ing the arm-soc guys as well.

-- 
Catalin
