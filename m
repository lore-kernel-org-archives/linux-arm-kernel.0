From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 19 May 2015 16:46:12 +0800
Subject: [PATCHv2 09/12] arm64: psci: factor invocation code to drivers
In-Reply-To: <1431945503-6939-10-git-send-email-mark.rutland@arm.com>
References: <1431945503-6939-1-git-send-email-mark.rutland@arm.com>
 <1431945503-6939-10-git-send-email-mark.rutland@arm.com>
Message-ID: <555AF854.3090909@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?05?18? 18:38, Mark Rutland wrote:
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
>   arch/arm64/Kconfig            |   1 +
>   arch/arm64/include/asm/psci.h |  27 ----
>   arch/arm64/kernel/psci.c      | 354 +---------------------------------------
>   arch/arm64/kernel/setup.c     |   2 +-
>   drivers/firmware/Kconfig      |   3 +
>   drivers/firmware/Makefile     |   1 +
>   drivers/firmware/psci.c       | 363 ++++++++++++++++++++++++++++++++++++++++++
>   include/linux/psci.h          |  51 ++++++
>   8 files changed, 422 insertions(+), 380 deletions(-)
>   delete mode 100644 arch/arm64/include/asm/psci.h
>   create mode 100644 drivers/firmware/psci.c
>   create mode 100644 include/linux/psci.h

Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
