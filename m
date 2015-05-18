From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 18 May 2015 18:40:20 +0100
Subject: [PATCHv2 09/12] arm64: psci: factor invocation code to drivers
In-Reply-To: <1431945503-6939-10-git-send-email-mark.rutland@arm.com>
References: <1431945503-6939-1-git-send-email-mark.rutland@arm.com>
 <1431945503-6939-10-git-send-email-mark.rutland@arm.com>
Message-ID: <20150518174020.GP21251@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 18, 2015 at 11:38:20AM +0100, Mark Rutland wrote:
> To enable sharing with arm, move the core PSCI framework code to
> drivers/firmware. This results in a minor gain in lines of code, but
> this will quickly be amortised by the removal of code currently
> duplicated in arch/arm.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/Kconfig            |   1 +
>  arch/arm64/include/asm/psci.h |  27 ----
>  arch/arm64/kernel/psci.c      | 354 +---------------------------------------
>  arch/arm64/kernel/setup.c     |   2 +-
>  drivers/firmware/Kconfig      |   3 +
>  drivers/firmware/Makefile     |   1 +
>  drivers/firmware/psci.c       | 363 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/psci.h          |  51 ++++++
>  8 files changed, 422 insertions(+), 380 deletions(-)
>  delete mode 100644 arch/arm64/include/asm/psci.h
>  create mode 100644 drivers/firmware/psci.c
>  create mode 100644 include/linux/psci.h

Did you use -M to generate this diff? Maybe for a subsequent post.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
