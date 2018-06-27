From: mpe@ellerman.id.au (Michael Ellerman)
Date: Wed, 27 Jun 2018 15:33:44 +1000
Subject: [PATCH v9 0/6] add support for relative references in special
 sections
In-Reply-To: <20180626182802.19932-1-ard.biesheuvel@linaro.org>
References: <20180626182802.19932-1-ard.biesheuvel@linaro.org>
Message-ID: <87r2ks6bev.fsf@concordia.ellerman.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ard Biesheuvel <ard.biesheuvel@linaro.org> writes:
> This adds support for emitting special sections such as initcall arrays,
> PCI fixups and tracepoints as relative references rather than absolute
> references. This reduces the size by 50% on 64-bit architectures, but
> more importantly, it removes the need for carrying relocation metadata
> for these sections in relocatable kernels (e.g., for KASLR) that needs
> to be fixed up at boot time. On arm64, this reduces the vmlinux footprint
> of such a reference by 8x (8 byte absolute reference + 24 byte RELA entry
> vs 4 byte relative reference)
...
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>

This seems to be working on powerpc.

It boots on a couple of machines with no obvious badness.

And there's some size reduction with a random config I had lying around:

  Total: Before=14820494, After=14673313, chg -0.99%


It can get some more testing once it's in linux-next as far as I'm
concerned.

  Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
