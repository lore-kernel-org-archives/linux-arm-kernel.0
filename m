From: mingo@kernel.org (Ingo Molnar)
Date: Wed, 25 Jul 2018 12:09:53 +0200
Subject: [PATCH] arm: asm/tlb.h: Fix build error implicit func declaration
In-Reply-To: <20180725095557.19668-1-anders.roxell@linaro.org>
References: <20180725095557.19668-1-anders.roxell@linaro.org>
Message-ID: <20180725100953.GA26481@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Anders Roxell <anders.roxell@linaro.org> wrote:

> Building on arm 32 with LPAE enabled we don't include asm-generic/tlb.h,
> where we have tlb_flush_remove_tables_local and tlb_flush_remove_tables
> defined.
> mm/memory.c: In function ?tlb_remove_table_smp_sync?:
> mm/memory.c:339:2: error: implicit declaration of function ?tlb_flush_remove_tables_local?; did you mean ?tlb_remove_table?? [-Werror=implicit-function-declaration]
>   tlb_flush_remove_tables_local(mm);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   tlb_remove_table
> mm/memory.c: In function ?tlb_table_flush?:
> mm/memory.c:372:2: error: implicit declaration of function ?tlb_flush_remove_tables?; did you mean ?tlb_remove_table?? [-Werror=implicit-function-declaration]
>   tlb_flush_remove_tables(tlb->mm);
>   ^~~~~~~~~~~~~~~~~~~~~~~
>   tlb_remove_table
> 
> To fix this issue we define them in arm 32's specific asm/tlb.h file.
> 
> Fixes: 2ff6ddf19c0e ("x86/mm/tlb: Leave lazy TLB mode at page table free time")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
> 
> Ingo, would it make sense for you to pick it up into the x86 tree since
> that contains the bug ?

Done and sorry about that! Will push your fix out to -next as well ASAP.

Thanks,

	Ingo
