From: mina86@mina86.com (Michal Nazarewicz)
Date: Wed, 16 Jul 2014 18:39:05 +0200
Subject: [PATCH 4/4] mips: dma: Add cma support
In-Reply-To: <1405525892-60383-5-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1405525892-60383-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <1405525892-60383-5-git-send-email-Zubair.Kakakhel@imgtec.com>
Message-ID: <xa1t7g3db6mu.fsf@mina86.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 16 2014, Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com> wrote:
> Adds cma support to the mips architecture.
>
> cma uses memblock. However, mips uses bootmem.

Does cma_early_percent_memory work correctly then?

> bootmem is informed about any regions reserved by memblock

Alternatively maybe it would make sense to create a new definition of
dma_contiguous_reserve_area that uses bootmem and choose it based on
some CONFIG_CMA_USE_BOOTMEM which would be selected by MIPS.

> dma api is modified to use cma reserved memory regions when available
>
> Tested using cma_test. cma_test is a simple driver that assigns blocks
> of memory from cma reserved sections.
>
> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>

Acked-by: Michal Nazarewicz <mina86@mina86.com>

> ---
>  arch/mips/Kconfig            |  1 +
>  arch/mips/include/asm/Kbuild |  1 +
>  arch/mips/kernel/setup.c     |  9 +++++++++
>  arch/mips/mm/dma-default.c   | 37 +++++++++++++++++++++++++------------
>  4 files changed, 36 insertions(+), 12 deletions(-)
>

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +--<mpn@google.com>--<xmpp:mina86@jabber.org>--ooO--(_)--Ooo--
