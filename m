From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 17 Oct 2014 18:19:08 +0100
Subject: [PATCH] arm64: mm: Correct fixmap pagetable types
In-Reply-To: <1413556058-27432-1-git-send-email-steve.capper@linaro.org>
References: <1413556058-27432-1-git-send-email-steve.capper@linaro.org>
Message-ID: <20141017171908.GK10873@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 17, 2014 at 03:27:38PM +0100, Steve Capper wrote:
> Compiling with STRICT_MM_TYPECHECKS gives the following
> arch/arm64/mm/ioremap.c: In function ?early_ioremap_init?:
> arch/arm64/mm/ioremap.c:152:2: warning: passing argument 3 of
> ?pud_populate? from incompatible pointer type
>   pud_populate(&init_mm, pud, bm_pmd);
> 
> The data types for bm_pmd and bm_pud are incorrectly set to pte_t.
> This patch corrects these types.
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>

Thanks. Applied.

-- 
Catalin
