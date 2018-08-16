From: Pavel.Tatashin@microsoft.com (Pasha Tatashin)
Date: Thu, 16 Aug 2018 22:54:38 +0000
Subject: [RESEND PATCH v10 2/6] mm: page_alloc: remain
 memblock_next_valid_pfn() on arm/arm64
In-Reply-To: <1530867675-9018-3-git-send-email-hejianet@gmail.com>
References: <1530867675-9018-1-git-send-email-hejianet@gmail.com>
 <1530867675-9018-3-git-send-email-hejianet@gmail.com>
Message-ID: <20180816225437.5zkchip422esdqwh@xakep.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18-07-06 17:01:11, Jia He wrote:
> From: Jia He <jia.he@hxt-semitech.com>
> 
> Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
> where possible") optimized the loop in memmap_init_zone(). But it causes
> possible panic bug. So Daniel Vacek reverted it later.
> 
> But as suggested by Daniel Vacek, it is fine to using memblock to skip
> gaps and finding next valid frame with CONFIG_HAVE_ARCH_PFN_VALID.
> Daniel said:
> "On arm and arm64, memblock is used by default. But generic version of
> pfn_valid() is based on mem sections and memblock_next_valid_pfn() does
> not always return the next valid one but skips more resulting in some
> valid frames to be skipped (as if they were invalid). And that's why
> kernel was eventually crashing on some !arm machines."
> 
> About the performance consideration:
> As said by James in b92df1de5,
> "I have tested this patch on a virtual model of a Samurai CPU
> with a sparse memory map.  The kernel boot time drops from 109 to
> 62 seconds."
> 
> Thus it would be better if we remain memblock_next_valid_pfn on arm/arm64.
> 
> Suggested-by: Daniel Vacek <neelx@redhat.com>
> Signed-off-by: Jia He <jia.he@hxt-semitech.com>

The version of this patch in linux-next has few fixes, I reviewed that one
looks good to me.

Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>
