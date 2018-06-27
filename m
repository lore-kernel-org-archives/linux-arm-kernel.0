From: will.deacon@arm.com (Will Deacon)
Date: Wed, 27 Jun 2018 16:15:11 +0100
Subject: [PATCH v9 0/6] add support for relative references in special
 sections
In-Reply-To: <20180626182802.19932-1-ard.biesheuvel@linaro.org>
References: <20180626182802.19932-1-ard.biesheuvel@linaro.org>
Message-ID: <20180627151510.GE30631@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On Tue, Jun 26, 2018 at 08:27:55PM +0200, Ard Biesheuvel wrote:
> This adds support for emitting special sections such as initcall arrays,
> PCI fixups and tracepoints as relative references rather than absolute
> references. This reduces the size by 50% on 64-bit architectures, but
> more importantly, it removes the need for carrying relocation metadata
> for these sections in relocatable kernels (e.g., for KASLR) that needs
> to be fixed up at boot time. On arm64, this reduces the vmlinux footprint
> of such a reference by 8x (8 byte absolute reference + 24 byte RELA entry
> vs 4 byte relative reference)
> 
> Patch #3 was sent out before as a single patch. This series supersedes
> the previous submission. This version makes relative ksymtab entries
> dependent on the new Kconfig symbol HAVE_ARCH_PREL32_RELOCATIONS rather
> than trying to infer from kbuild test robot replies for which architectures
> it should be blacklisted.
> 
> Patch #1 introduces the new Kconfig symbol HAVE_ARCH_PREL32_RELOCATIONS,
> and sets it for the main architectures that are expected to benefit the
> most from this feature, i.e., 64-bit architectures or ones that use
> runtime relocations.
> 
> Patch #2 add support for #define'ing __DISABLE_EXPORTS to get rid of
> ksymtab/kcrctab sections in decompressor and EFI stub objects when
> rebuilding existing C files to run in a different context.

I had a small question on patch 3, but it's really for my understanding.
So, for patches 1-3:

Reviewed-by: Will Deacon <will.deacon@arm.com>

Thanks,

Will
