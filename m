From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 19 Jun 2014 09:31:17 +0200
Subject: [PATCH] of: Check for phys_addr_t overflows in
 early_init_dt_add_memory_arch
In-Reply-To: <1403154257-14591-1-git-send-email-lauraa@codeaurora.org>
References: <1403154257-14591-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <CAMuHMdW854ThGRUSVohvowJksTbVAzZ2cWmjBrsD804LqmBH8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laura,

On Thu, Jun 19, 2014 at 7:04 AM, Laura Abbott <lauraa@codeaurora.org> wrote:
> The common early_init_dt_add_memory_arch takes the base and size
> of a memory region as u64 types. The function never checks if
> the base and size can actually fit in a phys_addr_t which may
> be smaller than 64-bits. This may result in incorrect memory
> being passed to memblock_add if the memory falls outside the
> range of phys_addr_t. Add range checks for the base and size if
> phys_addr_t is smaller than u64.
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>

Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

> ---
> Geert, can you drop my other patch and give this a test to see if it fixes
> your bootup problem?

Thanks, works fine!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
