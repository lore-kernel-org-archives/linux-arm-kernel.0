From: will.deacon@arm.com (Will Deacon)
Date: Mon, 25 Apr 2016 12:07:57 +0100
Subject: [PATCH v2 4/6] arm64: mm: dump: make page table dumping reusable
In-Reply-To: <1461343688-8552-5-git-send-email-ard.biesheuvel@linaro.org>
References: <1461343688-8552-1-git-send-email-ard.biesheuvel@linaro.org>
 <1461343688-8552-5-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160425110757.GI16065@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard, Mark,

On Fri, Apr 22, 2016 at 06:48:06PM +0200, Ard Biesheuvel wrote:
> From: Mark Rutland <mark.rutland@arm.com>
> 
> For debugging purposes, it would be nice if we could export page tables
> other than the swapper_pg_dir to userspace. To enable this, this patch
> refactors the arm64 page table dumping code such that multiple tables
> may be registered with the framework, and exported under debugfs.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/include/asm/ptdump.h | 44 ++++++++++++++++++++
>  arch/arm64/mm/dump.c            | 32 ++++++++------
>  2 files changed, 64 insertions(+), 12 deletions(-)

Could you reorder this with patch 3, please? I'm unsure about the benefit
of the very specific string literal changes, but the ptdump stuff here
certainly looks beneficial.

I can queue the first two patches as-is.

Thanks.

Will
