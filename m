From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 13 Feb 2017 08:13:41 +0000
Subject: Question about PTE_CONT in linux_4.10
In-Reply-To: <B99C36949BCC8541A564076B659DD9706714ED6D@nkgeml514-mbx.china.huawei.com>
References: <B99C36949BCC8541A564076B659DD9706714ED6D@nkgeml514-mbx.china.huawei.com>
Message-ID: <CAKv+Gu83n2MG4QaMsKTUnOy6WKTQFTgn-dYtyHWxr4g2419mcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 February 2017 at 08:04, Wangxuefeng (E) <wxf.wang@hisilicon.com> wrote:
> Hi Jeremy,
>
>         I has a question about change access permission(X-executable) in linux_4.10 when continuous bit enable.
>         In linux_4.10, the memories allocated by kmalloc are always set PTE_PXN and PTE_CONT. When I need change the access permission of the kmalloc area to make it has executable permission(clear PXN), what interface can I use?
>     The set_memory_x only change the PTE_PXN, but it doesn't change continuous bit. If only a 4K page change the permission, TLB conflict will happen. Is there any other interface can change the permission?
>

set_memory_x() can only be used on vmalloc/vmap regions, which don't
use PTE_CONT. Does set_memory_x() work for you on kmalloc allocations?
If so, that is a bug and we should fix it
