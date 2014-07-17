From: will.deacon@arm.com (Will Deacon)
Date: Thu, 17 Jul 2014 11:15:41 +0100
Subject: [PATCH v7 00/11] arm64: Support 4 levels of translation tables
In-Reply-To: <1405537792-23666-1-git-send-email-catalin.marinas@arm.com>
References: <1405537792-23666-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <20140717101540.GE21153@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 16, 2014 at 08:09:41PM +0100, Catalin Marinas wrote:
> Hi,
> 
> I've taken over Jungseok's 4-level page table series here:
> 
> https://lkml.kernel.org/g/000001cf6dc6$03ded0c0$0b9c7240$@samsung.com
> 
> I kept the same series numbering, so this is normally version 7. Changes
> since v6:
> 
> - Additional fixes for duplicate (SWAPPER|IDMAP)_DIR_SIZE definitions
> - Removed the fixmap pmd from swapper_pg_dir populated in head.S
> - Several clean-ups in Jungseok's patches (annotated above my
>   signed-off-by line)
> - Removal of the pgtable-*level-hwdef.h files
> - Converting levels config options to int ARM64_PGTABLE_LEVELS
> 
> Important change: I dropped the KVM support for 4 levels temporarily. I
> plan to revive them but didn't have for v7.

While you're looking at KVM, can you check if this breaks the SMMU driver
too, please? We re-use the CPU page-table functions in there and, whilst it
does have PUD code, a quick eyeball/test wouldn't hurt.

Will
