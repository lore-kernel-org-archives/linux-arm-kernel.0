From: naresh.kamboju@linaro.org (Naresh Kamboju)
Date: Sat, 6 Oct 2018 00:50:05 -0700
Subject: [PATCH] hugetlb: fix ARM 3level page tables
In-Reply-To: <20181005161722.904274-1-arnd@arndb.de>
References: <20181005161722.904274-1-arnd@arndb.de>
Message-ID: <CA+G9fYs-z-CQ+HgFcosYsNphAmU2rG56PTFqO48T-pZ_63Ujuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

On Fri, 5 Oct 2018 at 09:17, Arnd Bergmann <arnd@arndb.de> wrote:
>
> The check for __HAVE_ARCH_HUGE_PTEP_GET comes before the definition,
> leading to an extraneous definition of huge_ptep_get:
>
> In file included from arch/arm/include/asm/hugetlb.h:28,
>                  from include/linux/hugetlb.h:456,
>                  from arch/arm/kvm/../../../virt/kvm/arm/mmu.c:22:
> arch/arm/include/asm/hugetlb-3level.h:33:21: error: redefinition of 'huge_ptep_get'
>  static inline pte_t huge_ptep_get(pte_t *ptep)
>
> Change the header file inclusions to be in the correct order for
> this to work.
>
> Fixes: bb1d18ffc7ae ("hugetlb: introduce generic version of huge_ptep_get")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I have noticed this build error on linux next tree for arm32 build.
Thanks for the fix.

- Naresh
