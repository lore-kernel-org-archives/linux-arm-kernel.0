From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 25 Sep 2017 10:10:15 +0100
Subject: [RFC PATCH 0/3] arm64: Support Common Not Private translations
In-Reply-To: <1502707134-10853-1-git-send-email-vladimir.murzin@arm.com>
References: <1502707134-10853-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <4042ad51-f6b1-1014-8af7-5b0cbacbaede@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/08/17 11:38, Vladimir Murzin wrote:
> Common Not Private (CNP) translations is a feature of ARMv8.2
> extension which allows translation table entries to be shared between
> different PEs in the same inner shareable domain, so the hardware can
> use this fact to optimise the caching of such entries in the TLB.
> 
> This patch set is an attempt to bring CNP support into Linux. It was
> tested on a v8.2 Fast Model with exploring traces and checking that
> TTBRx_ELy and VTTBR_EL2 have CnP bit set where appropriate.

Any comments before I start rebasing it?

Cheers
Vladimir

> 
> Thanks!
> 
> Vladimir Murzin (3):
>   arm64: mm: Support Common Not Private translations
>   arm64: KVM: Support Common Not Private translations
>   arm64: Introduce command line parameter to disable CNP
> 
>  Documentation/admin-guide/kernel-parameters.txt |  4 +++
>  arch/arm64/Kconfig                              | 12 ++++++++
>  arch/arm64/include/asm/asm-uaccess.h            |  2 ++
>  arch/arm64/include/asm/cpucaps.h                |  3 +-
>  arch/arm64/include/asm/cpufeature.h             |  6 ++++
>  arch/arm64/include/asm/memory.h                 |  1 +
>  arch/arm64/include/asm/mmu_context.h            | 14 +++++++++
>  arch/arm64/include/asm/uaccess.h                | 10 +++++--
>  arch/arm64/kernel/cpufeature.c                  | 40 +++++++++++++++++++++++++
>  arch/arm64/kernel/hibernate.c                   |  2 +-
>  arch/arm64/kvm/hyp-init.S                       |  4 +++
>  arch/arm64/kvm/hyp/switch.c                     |  6 +++-
>  arch/arm64/mm/proc.S                            |  5 ++++
>  13 files changed, 104 insertions(+), 5 deletions(-)
> 
