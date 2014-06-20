From: cov@codeaurora.org (Christopher Covington)
Date: Fri, 20 Jun 2014 09:54:12 -0400
Subject: [PATCHv2] mm: page_alloc: fix CMA area initialisation when
 pageblock > MAX_ORDER
In-Reply-To: <xa1td2e41xs2.fsf@mina86.com>
References: <1402522435-13884-1-git-send-email-msalter@redhat.com>
 <alpine.DEB.2.02.1406111557030.27885@chino.kir.corp.google.com>
 <xa1t61jzwfo6.fsf@mina86.com> <1403201524.32688.62.camel@deneb.redhat.com>
 <xa1td2e41xs2.fsf@mina86.com>
Message-ID: <53A43D04.9050105@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/19/2014 03:53 PM, Michal Nazarewicz wrote:
> With a kernel configured with ARM64_64K_PAGES && !TRANSPARENT_HUGEPAGE,
> the following is triggered at early boot:
> 
>   SMP: Total of 8 processors activated.
>   devtmpfs: initialized
>   Unable to handle kernel NULL pointer dereference at virtual address 00000008
>   pgd = fffffe0000050000
>   [00000008] *pgd=00000043fba00003, *pmd=00000043fba00003, *pte=00e0000078010407
>   Internal error: Oops: 96000006 [#1] SMP
>   Modules linked in:
>   CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.15.0-rc864k+ #44
>   task: fffffe03bc040000 ti: fffffe03bc080000 task.ti: fffffe03bc080000
>   PC is at __list_add+0x10/0xd4
>   LR is at free_one_page+0x270/0x638
>   ...
>   Call trace:
>   [<fffffe00003ee970>] __list_add+0x10/0xd4
>   [<fffffe000019c478>] free_one_page+0x26c/0x638
>   [<fffffe000019c8c8>] __free_pages_ok.part.52+0x84/0xbc
>   [<fffffe000019d5e8>] __free_pages+0x74/0xbc
>   [<fffffe0000c01350>] init_cma_reserved_pageblock+0xe8/0x104
>   [<fffffe0000c24de0>] cma_init_reserved_areas+0x190/0x1e4
>   [<fffffe0000090418>] do_one_initcall+0xc4/0x154
>   [<fffffe0000bf0a50>] kernel_init_freeable+0x204/0x2a8
>   [<fffffe00007520a0>] kernel_init+0xc/0xd4

I just ran into this. Thanks for the fix.

Tested-by: Christopher Covington <cov@codeaurora.org>

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
