From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 18 Jul 2013 16:26:18 +0100
Subject: [PATCH 0/3] arm/arm64: a trio of boot mode detection fixes
In-Reply-To: <1373379366-15689-1-git-send-email-mark.rutland@arm.com>
References: <1373379366-15689-1-git-send-email-mark.rutland@arm.com>
Message-ID: <51E8091A.5040302@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/07/13 15:16, Mark Rutland wrote:
> The following patches fix a couple of issues in the boot mode detection
> code where in the case of mismatched boot modes we can corrupt a small
> portion of memory or fail to detect the fact we've booted CPUs with
> mismatched modes due to the boot mode being logged incoherently.

Sorry for the delay in replying to this. The whole series looks good to
me, so: Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.

> Thanks,
> Mark.
> 
> Mark Rutland (3):
>   arm: hyp: fix macro parameterisation
>   arm: virt: ensure visibility of __boot_cpu_mode
>   arm64: virt: ensure visibility of __boot_cpu_mode
> 
>  arch/arm/include/asm/virt.h   | 12 ++++++++++++
>  arch/arm/kernel/hyp-stub.S    |  4 ++--
>  arch/arm/kernel/setup.c       |  2 ++
>  arch/arm64/include/asm/virt.h | 13 +++++++++++++
>  4 files changed, 29 insertions(+), 2 deletions(-)
> 


-- 
Jazz is not dead. It just smells funny...
