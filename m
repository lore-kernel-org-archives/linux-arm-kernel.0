From: akpm@linux-foundation.org (Andrew Morton)
Date: Mon, 19 May 2014 12:51:36 -0700
Subject: + arm-move-arm_dma_limit-to-setup_dma_zone.patch added to -mm tree
In-Reply-To: <CAKv+Gu_QCJn5UGyM4zEPLvkTPMnfwTM2qKYnBU42vEPwwt6-Dg@mail.gmail.com>
References: <CAKv+Gu_QCJn5UGyM4zEPLvkTPMnfwTM2qKYnBU42vEPwwt6-Dg@mail.gmail.com>
Message-ID: <20140519125136.caafeb3868d4a0eebc4e5371@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 18 May 2014 22:49:16 -0700 Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> Gents,
> 
> I noticed this patch turning up in -next:
> http://ozlabs.org/~akpm/mmots/broken-out/arm-move-arm_dma_limit-to-setup_dma_zone.patch
> 
> which I think is incorrect. More specifically, it replaces a reference
> to arm_dma_limit, which is defined as either
> 
> arch/arm/mm/init.c:177:         arm_dma_limit = PHYS_OFFSET +
> arm_dma_zone_size - 1;
> 
> or
> 
> arch/arm/mm/init.c:179:         arm_dma_limit = 0xffffffff;
> 
> with 'arm_dma_pfn_limit << PAGE_SHIFT', which means the bottom
> PAGE_SHIFT '1' bytes are lost.

That patch has been floating about in "stuck" state for months.

I think I'll drop it.  Vladimir, please resend something if you think
it still should be addressed.
