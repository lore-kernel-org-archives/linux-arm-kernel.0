From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 06 Mar 2018 10:32:13 +0000
Subject: [PATCH v2] arm64: KVM: Use SMCCC_ARCH_WORKAROUND_1 for Falkor BP
 hardening
In-Reply-To: <1520269603-2900-1-git-send-email-shankerd@codeaurora.org>
References: <1520269603-2900-1-git-send-email-shankerd@codeaurora.org>
Message-ID: <861sgx5wb6.wl-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 05 Mar 2018 17:06:43 +0000,
Shanker Donthineni wrote:
> 
> The function SMCCC_ARCH_WORKAROUND_1 was introduced as part of SMC
> V1.1 Calling Convention to mitigate CVE-2017-5715. This patch uses
> the standard call SMCCC_ARCH_WORKAROUND_1 for Falkor chips instead
> of Silicon provider service ID 0xC2001700.
> 
> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
> ---
> Chnages since v1:
>   - Trivial change in cpucaps.h (refresh after removing ARM64_HARDEN_BP_POST_GUEST_EXIT)
> 
>  arch/arm64/include/asm/cpucaps.h |  5 ++--
>  arch/arm64/include/asm/kvm_asm.h |  2 --
>  arch/arm64/kernel/bpi.S          |  8 ------
>  arch/arm64/kernel/cpu_errata.c   | 55 ++++++++++++++--------------------------
>  arch/arm64/kvm/hyp/entry.S       | 12 ---------
>  arch/arm64/kvm/hyp/switch.c      | 10 --------
>  6 files changed, 21 insertions(+), 71 deletions(-)

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

Will/Catalin, if you want to take it via the arm64 tree, that's fine
by me.

Thanks,

	M.

-- 
Jazz is not dead, it just smell funny.
