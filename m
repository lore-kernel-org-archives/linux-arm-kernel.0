From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 14 Oct 2016 11:28:54 +0100
Subject: [PATCH v3 4/5] arm64: mm: support additional contiguous kernel
 mapping region sizes
In-Reply-To: <1476271425-19401-5-git-send-email-ard.biesheuvel@linaro.org>
References: <1476271425-19401-1-git-send-email-ard.biesheuvel@linaro.org>
 <1476271425-19401-5-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20161014102853.GA23339@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 12, 2016 at 12:23:44PM +0100, Ard Biesheuvel wrote:
> Extend the basic support for kernel mappings using contiguous regions
> by adding support for contiguous PUDs (4k granule only), either as a
> discrete level or folded into the PGDs. In the same way, handle folded
> PMDs so that contiguous PMDs (for 16k and 64k granule kernels) will
> work as expected for 2 levels of translation as well.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/include/asm/pgtable-hwdef.h |  6 +++
>  arch/arm64/mm/mmu.c                    | 40 +++++++++++++++++++-
>  2 files changed, 44 insertions(+), 2 deletions(-)

After looking at this patch, I concluded it's not worth hassle as no
hardware I'm aware of currently would benefit from it.  We can revisit
it in the future if we hear otherwise.

-- 
Catalin
