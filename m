From: jamie@shareable.org (Jamie Lokier)
Date: Wed, 30 Dec 2009 18:49:29 +0000
Subject: [PATCH] Valid relocation symbol for FLAT format on ARM
In-Reply-To: <52886e760912300830n2234e01bm2e300828141d226@mail.gmail.com>
References: <52886e760912300830n2234e01bm2e300828141d226@mail.gmail.com>
Message-ID: <20091230184929.GB22469@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jun Sun wrote:
>    (Sent to linux-kernel, but seems nobody cared. Hopefully someone here
>    can pick it up)

I've included uclinux-dev at uclinux.org, because that's where I've seen
most discussion of FLAT format in general.

>    Apparently newer GCC would generate ANCHOR symbols beyond the end of
>    data/bss segment on ARM CPUs. As a result, the exiting validity checking
>    for relocation symbols in FLAT format will fail for some programs.

> -#define        flat_reloc_valid(reloc, size)           ((reloc) <= (size))
> +#define        flat_reloc_valid(reloc, size)           ((reloc) <= (size) + 0x1000)

Why 0x1000?  Is that an arbitrary number, or does it have a specific
meaning for GCC?

>    This also fixes a cosmetic error in printk. Text segment and data/bss
>    segment are allocated from two different areas. It is not meaningful to
>    give the diff between them in error reporting messages.

That part looks fine to me.

-- Jamie

ps. Russell, proof that someone is using no-MMU ARM? :-)
I'll get back to your earlier mail on that subject when I have more time, btw.
