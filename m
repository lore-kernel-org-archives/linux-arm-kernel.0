From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 16 Aug 2017 18:16:57 +0100
Subject: [PATCH 0/6] Rework the pte handling for hardware AF/DBM
In-Reply-To: <20170725135308.18173-1-catalin.marinas@arm.com>
References: <20170725135308.18173-1-catalin.marinas@arm.com>
Message-ID: <20170816171657.2ynjxcfeyt7qoegz@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 25, 2017 at 02:53:02PM +0100, Catalin Marinas wrote:
> Catalin Marinas (6):
>   arm64: Fix potential race with hardware DBM in ptep_set_access_flags()

This has been merged into 4.13.

>   arm64: Convert pte handling from inline asm to using (cmp)xchg
>   kvm: arm64: Convert kvm_set_s2pte_readonly() from inline asm to
>     cmpxchg()
>   arm64: Move PTE_RDONLY bit handling out of set_pte_at()
>   arm64: Ignore hardware dirty bit updates in ptep_set_wrprotect()
>   arm64: Remove the CONFIG_ARM64_HW_AFDBM option

Unless there are strong objections, I'm going to merge patches 2-4,6
into for-next/core. I'd like some more reviews on patch 5 (ignoring the
hardware DBM updates in ptep_set_wrprotect()) as this is a functional
change. The others are simply converting the asm code into C.

Thanks.

-- 
Catalin
