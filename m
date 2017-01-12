From: will.deacon@arm.com (Will Deacon)
Date: Thu, 12 Jan 2017 17:33:53 +0000
Subject: [PATCHv7 00/11] CONFIG_DEBUG_VIRTUAL for arm64
In-Reply-To: <1484084150-1523-1-git-send-email-labbott@redhat.com>
References: <1484084150-1523-1-git-send-email-labbott@redhat.com>
Message-ID: <20170112173352.GJ13843@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 10, 2017 at 01:35:39PM -0800, Laura Abbott wrote:
> This is v7 of the patches to add CONFIG_DEBUG_VIRTUAL for arm64. This is
> a simple reordering of patches from v6 per request of Will Deacon for ease
> of merging support for arm which depends on this series.
> 
> Laura Abbott (11):
>   lib/Kconfig.debug: Add ARCH_HAS_DEBUG_VIRTUAL
>   mm/cma: Cleanup highmem check
>   mm: Introduce lm_alias
>   kexec: Switch to __pa_symbol
>   mm/kasan: Switch to using __pa_symbol and lm_alias
>   mm/usercopy: Switch to using lm_alias
>   drivers: firmware: psci: Use __pa_symbol for kernel symbol
>   arm64: Move some macros under #ifndef __ASSEMBLY__
>   arm64: Add cast for virt_to_pfn
>   arm64: Use __pa_symbol for kernel symbols
>   arm64: Add support for CONFIG_DEBUG_VIRTUAL

I've pushed this into linux-next and, assuming it survives the
autobuilders etc I'll co-ordinate with Russell to get the common parts
pulled into the ARM tree too (so he can take Florian's series). They're
currently split out on the arm64 for-next/debug-virtual branch.

Thanks!

Will
