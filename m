From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 11 Oct 2016 16:46:01 +0100
Subject: [PATCH v2 0/3] arm64/mm: use the contiguous attribute for kernel
 mappings
In-Reply-To: <1476189589-1443-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1476189589-1443-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <CAKv+Gu93VDi80ETG4sd097xb6MSUQfy-ap0F-+qNJoakBy15Xw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 October 2016 at 13:39, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> This 3-piece series is a followup to the single patch 'arm64: mmu: set the
> contiguous for kernel mappings when appropriate' sent out on the 10th [0].
>
> This v2 addresses the following issues:
> - the contiguous attribute is also useful for contigous PMD mappings on 16k
>   granule kernels (i.e., 1 GB blocks)
> - the function parameter 'block_mappings_allowed' does not clearly convey
>   whether contiguous page mappings should be used, so it is renamed to
>   'page_mappings_only', and its meaning inverted
> - instead of BUGging on changes in the PTE_CONT attribute in PMD or PTE entries
>   that have been populated already, BUG on any modification except for
>   permission attributes, which don't require break-before-make when changed.
>
> [0] http://marc.info/?l=linux-arm-kernel&m=147612332130714
>

In addition to the fact, as mentioned by Will, that contiguous PMDs
are supported for 4k and 64k granules too, this series fails to deal
with folded PUDs and PMDs (which should result in contiguous PGDs for
2 level or 3 level configurations)

Since this is no longer a drive-by patch, I wil take some time for the
v3 and address all the corner cases, and do some more elaborate
testing.

-- 
Ard.
